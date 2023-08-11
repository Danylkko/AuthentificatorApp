//
//  CentralTimer.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 08.08.2023.
//

import Foundation
import Combine

class CentralTimer {
    
    static let shared = CentralTimer()

    private let timerSubject = PassthroughSubject<Void, Never>()
    private var timer: Timer?
    
    var firePublisher: AnyPublisher<Void, Never> {
        timerSubject.eraseToAnyPublisher()
    }

    
    private init() { start() }
    
    func start() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.timerSubject.send()
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        timer?.invalidate()
    }
}
