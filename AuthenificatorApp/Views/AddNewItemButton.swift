//
//  AddNewItemButton.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 04.07.2023.
//

import UIKit

class AddNewItemButton: UIButton {
    
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
            layer.masksToBounds = true
            layer.cornerRadius = rect.size.width / 2
            
            let crossPath = drawAddingCross(for: rect)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = crossPath.cgPath
            shapeLayer.strokeColor = UIColor.white.cgColor
            shapeLayer.lineWidth = 5
            shapeLayer.lineCap = .round
            layer.addSublayer(shapeLayer)
        }
    }
    
    func drawAddingCross(for rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let crossSide: Double = 25
        
        // Vertical line
        path.move(to: CGPoint(x: rect.midX, y: rect.midY - crossSide / 2))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY + crossSide / 2))
        
        // Horizontal line
        path.move(to: CGPoint(x: rect.midX - crossSide / 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + crossSide / 2, y: rect.midY))
        
        return path
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
