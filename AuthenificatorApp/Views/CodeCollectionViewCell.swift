//
//  CodeCollectionViewCell.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 03.07.2023.
//

import UIKit

class CodeCollectionViewCell: UICollectionViewCell {
    
    public static let reuseId = "codeCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 10
    }
    
}
