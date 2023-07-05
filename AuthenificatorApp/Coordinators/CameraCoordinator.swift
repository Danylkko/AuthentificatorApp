//
//  CameraCoordinator.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 05.07.2023.
//

import UIKit

class CameraCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func childDidFinish(_ child: Coordinator?) {
        
    }
    
    
}
