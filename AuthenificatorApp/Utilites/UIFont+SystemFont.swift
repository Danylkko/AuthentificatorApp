//
//  UIFont+SystemFont.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 06.07.2023.
//

import UIKit

extension UIFont {
    
    static var fontWithWeight: [UIFont.Weight: String] {
        [
        .regular : "Poppins-Regular",
        .bold: "Poppins-Bold",
        .light: "Poppins-Light"
        ]
    }
    
    static func customFont(size: CGFloat, weight: UIFont.Weight) -> UIFont? {
        guard let fontName = fontWithWeight[weight] else { return nil }
        return UIFont(name: fontName, size: size)
    }
}

extension UIFont {
    struct Constants {
        static let fontName = "Poppins-Regular"
        static let labelSize: CGFloat = 24
        static let titleSize: CGFloat = 16
        static let textSize: CGFloat = 14
        static let hintSize: CGFloat = 12
    }
}
