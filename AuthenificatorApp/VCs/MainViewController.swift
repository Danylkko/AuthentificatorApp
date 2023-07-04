//
//  ViewController.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 02.07.2023.
//

import UIKit

class MainViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    @IBOutlet private weak var codesCollectionView: UICollectionView!
    @IBOutlet private weak var addNewCodeButton: PrimaryUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Authenticator+"
        
        configureCodesCV()
        configureButtons()
    }
    
    @objc
    private func scan() {
        coordinator?.scan()
    }
    
    private func configureButtons() {
        addNewCodeButton.shape = .circle
        addNewCodeButton.setNeedsDisplay()
        
        addNewCodeButton.addTarget(nil, action: #selector(scan), for: .touchUpInside)
    }

    
    private func configureCodesCV() {
        let nib = UINib(nibName: "CodeCollectionViewCell", bundle: nil)
        codesCollectionView.register(
            nib,
            forCellWithReuseIdentifier: CodeCollectionViewCell.reuseId
        )
        codesCollectionView.register(
            FooterCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: FooterCollectionReusableView.reuseId
        )
        codesCollectionView.dataSource = self
        codesCollectionView.delegate = self
    }
    
}

