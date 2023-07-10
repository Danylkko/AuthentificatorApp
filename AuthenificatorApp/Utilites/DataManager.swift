//
//  DataManager.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 08.07.2023.
//

import Foundation
import OneTimePassword
import Combine

class DataManager {
    
    public static let shared = DataManager()
    private let keychain = Keychain.sharedInstance
    
    let output = CurrentValueSubject<[AuthToken], Never>([])
    let addRecord = PassthroughSubject<URL, Never>()
    let fetchRecords = PassthroughSubject<Void, Never>()
    private var cn = Set<AnyCancellable>()
    
    init() {
        fetchRecords
            .compactMap { [weak self] in
                self?
                    .fetchRecordsFromKeychain()
                    .map { AuthToken(token: $0) }
            }
            .sink { [weak self] tokens in
                self?.output.send(tokens)
            }.store(in: &cn)
        
        addRecord
            .sink { [weak self] uri in
                self?.addRecordToKeychainWith(uri: uri)
                self?.fetchRecords.send()
            }.store(in: &cn)
    }
    
    let onAddError = PassthroughSubject<DataManager.Error, Never>()
    
    private func addRecordToKeychainWith(uri: URL) {
        guard let token = Token(url: uri) else {
            onAddError.send(DataManager.Error.serializaionError)
            return
        }
        guard let _ = try? keychain.add(token) else {
            onAddError.send(DataManager.Error.insertionError)
            return
        }
    }
    
    private func fetchRecordsFromKeychain() -> [Token] {
        do {
            let persistantTokens = try keychain.allPersistentTokens()
            return persistantTokens.map(\.token)
        } catch {
            NSLog("An error occured while fetching tokens from keychain. Error: \(error.localizedDescription)")
        }
        return []
    }
    
    enum Error: Swift.Error {
        
        case serializaionError
        case insertionError
        
        var description: String {
            switch self {
            case .serializaionError:
                return "An error occured while serializing given URI into Token."
            case .insertionError:
                return "An error occured while adding new Token into Keychain."
            }
        }
    }
    
    struct AuthToken {
        private let token: Token
        
        init(token: Token) {
            self.token = token
        }
        
        var name: String {
            token.name
        }
        
        var issuer: String {
            token.issuer
        }
        
        var currentPassword: String? {
            token.currentPassword
        }
        
        var period: Double {
            switch token.generator.factor {
            case .timer(let period):
                return period
            case .counter:
                return 0
            }
        }
    }
}
