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
                self?.scheduleUpdate(period: token.period, interval: 1.0)
            }.store(in: &cn)
    }
    
    func scheduleUpdate(period: TimeInterval, interval: TimeInterval) {
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            let currentTime = Date().timeIntervalSince1970
            let remainingTime = period - (currentTime.truncatingRemainder(dividingBy: period))
            self?.outTime.send(remainingTime)
        }
        timer.fire()
    }
}
