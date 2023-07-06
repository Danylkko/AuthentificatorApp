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
        let scannerViewController = ScannerViewController.instantiate()
        scannerViewController.coordinator = self
        scannerViewController.cameraVC = CameraViewController()
        if let sheet = scannerViewController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        navigationController.present(scannerViewController, animated: true, completion: nil)
    }
    
    func dismissScanner() {
        navigationController.dismiss(animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        print("Child of ScannerCoordinator did finish!")
    }
    
}
