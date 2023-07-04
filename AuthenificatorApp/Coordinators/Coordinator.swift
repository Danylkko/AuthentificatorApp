//
//  Coordinator.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 02.07.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
