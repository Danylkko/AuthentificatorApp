//
//  TimerView.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 10.07.2023.
//

import UIKit

class TimerView: UIView {
    
    var period: TimeInterval = 30
    var remainingTime: TimeInterval = 30
    var timeShapeLayer: CAShapeLayer?
    
    override func draw(_ rect: CGRect) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = drawTimeArc(for: remainingTime,
                                      of: period,
                                      within: rect).cgPath
        shapeLayer.lineWidth = 5
        shapeLayer.strokeColor = UIColor.lightBlue.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        if let oldShapeLayer = timeShapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.addSublayer(shapeLayer)
        }
        
        timeShapeLayer = shapeLayer
    }
    
    private func drawTimeArc(for currentTime: TimeInterval, of overallTime: TimeInterval, within rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let center = CGPoint(x: rect.minX + rect.width / 2,
                             y: rect.minY + rect.height / 2)
        let radius: CGFloat = min(rect.width, rect.height) / 2
        let angle: CGFloat = (currentTime / overallTime * 2 * .pi) - .pi / 2
        path.addArc(withCenter: center,
                    radius: radius,
                    startAngle: 3 * .pi / 2,
                    endAngle: angle,
                    clockwise: true)
        return path
    }
}
