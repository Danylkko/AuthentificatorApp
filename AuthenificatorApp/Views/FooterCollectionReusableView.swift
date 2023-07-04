//
//  FooterCollectionReusableView.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 04.07.2023.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {
    
    public static let reuseId = "footerId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }
}
