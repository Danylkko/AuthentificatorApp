//
//  CodeCellViewModel.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 10.07.2023.
//

import Foundation
import Combine

class CodeCellViewModel {
    
    let outSubject = PassthroughSubject<DataManager.AuthToken, Never>()
    let outTime = PassthroughSubject<TimeInterval, Never>()
    private var cn = Set<AnyCancellable>()
    
    init() {
        outSubject
            .sink { [weak self] token in
                self?.scheduleUpdate(for: token, interval: 1.0)
            }.store(in: &cn)
        
        outTime
            .filter { (0...1).contains($0) }
            .sink { _ in
                DataManager.shared.fetchRecords.send()
            }.store(in: &cn)
    }
    
    func scheduleUpdate(for token: DataManager.AuthToken, interval: TimeInterval) {
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            let currentTime = Date().timeIntervalSince1970
            let remainingTime = token.period - (currentTime.truncatingRemainder(dividingBy: token.period))
            
            self?.outTime.send(remainingTime)
        }
        timer.fire()
    }
}
