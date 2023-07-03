//
//  ViewController.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 02.07.2023.
//

import UIKit

class MainViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var codesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Authenticator+"
        
        configureCodesCV()
    }
    
    private func configureCodesCV() {
        let nib = UINib(nibName: "CodeCollectionViewCell", bundle: nil)
        codesCollectionView.register(nib, forCellWithReuseIdentifier: "codeCell")
        codesCollectionView.dataSource = self
        codesCollectionView.delegate = self
    }
    
}

