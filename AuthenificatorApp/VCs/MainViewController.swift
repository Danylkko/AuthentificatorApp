//
//  ViewController.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 02.07.2023.
//

import UIKit
import Combine

class MainViewController: UIViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    @IBOutlet private weak var codesCollectionView: UICollectionView!
    @IBOutlet private weak var addNewCodeButton: AddNewItemButton!
    
    private(set) var userTokens = [DataManager.AuthToken]()
    private var cn = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Authenticator+"
        configureCodesCV()
        configureButtons()
        configureCombine()
    }
    
    private func configureCombine() {
        DataManager.shared
            .output.sink { [weak self] authTokens in
                self?.userTokens = authTokens
                DispatchQueue.main.async {
                    self?.codesCollectionView.reloadData()
                }
            }.store(in: &cn)
        
        DataManager.shared
            .fetchRecords.send()
    }
    
    @objc
    private func scan() {
        coordinator?.scan()
    }
    
    private func configureButtons() {
        addNewCodeButton.shape = .circle
        addNewCodeButton.setTitle("+", for: .normal)
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

