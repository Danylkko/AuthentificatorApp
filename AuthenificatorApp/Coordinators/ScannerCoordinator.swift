//
//  ScannerCoordinator.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 04.07.2023.
//

import UIKit

class ScannerCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewControllerToPresent = ScannerViewController.instantiate()
        viewControllerToPresent.coordinator = self
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        navigationController.present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func dismissScanner() {
        navigationController.dismiss(animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        print("Child of ScannerCoordinator did finish!")
    }
    
}
