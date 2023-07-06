//
//  String+UsingSystemFont.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 05.07.2023.
//

import Foundation
import UIKit

extension String {
    public func attributedStringUsingCustomFont(size: CGFloat, weight: UIFont.Weight) -> NSAttributedString {
        let font = UIFont.customFont(size: size, weight: weight) ?? .systemFont(ofSize: size, weight: weight)
        let attribs = [NSAttributedString.Key.font: font,
                       NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSAttributedString(
            string: self,
            attributes: attribs)
        return attributedString
    }
}
