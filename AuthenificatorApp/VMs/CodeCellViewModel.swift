//
//  CodeCellViewModel.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 10.07.2023.
//

import Foundation
import Combine
import QuartzCore

class CodeCellViewModel {
    
    let outSubject = PassthroughSubject<DataManager.AuthToken, Never>()
    let outTime = PassthroughSubject<TimeInterval, Never>()
    private var cn = Set<AnyCancellable>()
    
    private var updateTimer: Timer?
    private var currentToken: DataManager.AuthToken?
    
    init() {
        outSubject
            .sink { [weak self] token in
                if self?.currentToken != token {
                    self?.currentToken = token
                    self?.scheduleUpdate(for: token, interval: 1.0)
                }
            }.store(in: &cn)
        
        outTime
            .filter { (28...30).contains($0) }
            .sink { [weak self] _ in
                guard let token = self?.currentToken else { return }
                self?.outSubject.send(token)
            }.store(in: &cn)
        
    }
    
    func scheduleUpdate(for token: DataManager.AuthToken, interval: TimeInterval) {
        updateTimer?.invalidate()
        updateTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            let currentTime = Date().timeIntervalSince1970
            let remainingTime = token.period - (currentTime.truncatingRemainder(dividingBy: token.period))
            self?.outTime.send(remainingTime)
        }
        updateTimer?.fire()
    }
}
