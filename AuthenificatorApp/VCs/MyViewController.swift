//
//  ViewController.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 02.07.2023.
//

import UIKit

class MyViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buyPressed(_ sender: Any) {
        coordinator?.buySubscription()
    }
    
    @IBAction func createPressed(_ sender: Any) {
        coordinator?.createAccount()
    }
    
}

