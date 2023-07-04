//
//  PrimaryUIButton.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 04.07.2023.
//

import UIKit

class PrimaryUIButton: UIButton {
    
    var shape: Shape?
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = .cyan
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        if shape == .circle {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = rect.size.width / 2
        }
        setCustomTitle()
    }
    
    private func setCustomTitle() {
        let text = self.titleLabel?.text ?? "Button"
        let attribs = [NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 42)!,
                       NSAttributedString.Key.foregroundColor: UIColor.white]
        let title = NSAttributedString(
            string: text,
            attributes: attribs)
        self.setAttributedTitle(title, for: .normal)
    }
    
    init(frame: CGRect, shape: Shape) {
        super.init(frame: frame)
        self.shape = shape
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    enum Shape {
        case circle
        case rectangle
    }
    
}
