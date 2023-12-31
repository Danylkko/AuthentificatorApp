//
//  MainViewController+UICollectionViewDelegate.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 03.07.2023.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userTokens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = CodeCollectionViewCell.reuseId
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? CodeCollectionViewCell else {
            fatalError("Cell type mismatch!")
        }
        let token = userTokens[indexPath.row]
        cell.configureUI()
        cell.configureCombine()
        cell.vm.outSubject.send(token)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.size.width - 20,
               height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10 )
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: FooterCollectionReusableView.reuseId,
                for: indexPath
            )
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: view.frame.size.width,
               height: view.frame.size.width / 2)
    }
    
}
