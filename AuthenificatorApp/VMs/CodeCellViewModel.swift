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
            .filter { [weak self] token in self?.currentToken != token }
            .sink { [weak self] token in
                self?.currentToken = token
            }
            .store(in: &cn)
        
        CentralTimer
            .shared
            .firePublisher
            .sink { [weak self] _ in
                guard let self, let token = self.currentToken else { return }
                let remainingTime = self.computeRemainingTime(period: token.period)
                self.outTime.send(remainingTime)
            }.store(in: &cn)
        
        outTime
            .sink { [weak self] _ in
                guard let token = self?.currentToken else { return }
                self?.outSubject.send(token)
            }.store(in: &cn)
        
    }
    
    private func computeRemainingTime(period: Double) -> Double {
        let currentDate = Date().timeIntervalSince1970
        let remainingTime = period - (currentDate.truncatingRemainder(dividingBy: period))
        return remainingTime
    }
    
}
