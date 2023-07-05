//
//  QRFrameView.swift
//  AuthenificatorApp
//
//  Created by Danylo Litvinchuk on 05.07.2023.
//

import UIKit

class QRFrameView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let cornerLayer = CAShapeLayer()
        let cornerPath = makeCornerPath(for: rect, cornerRadius: 30, angleSize: 20)
        
        cornerLayer.path = cornerPath.cgPath
        cornerLayer.lineCap = .round
        cornerLayer.strokeColor = UIColor.lightBlue.cgColor
        cornerLayer.lineWidth = 7
        cornerLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(cornerLayer)
    }
    
    func makeCornerPath(for rect: CGRect, cornerRadius: CGFloat, angleSize: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        // Top left corner
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius + angleSize))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minX + cornerRadius))
        var arcCenter = CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius)
        path.addArc(withCenter: arcCenter, radius: cornerRadius, startAngle: .pi, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius + angleSize, y: rect.minY))
        
        // Top right corner
        path.move(to: CGPoint(x: rect.maxX - cornerRadius - angleSize, y: rect.minX))
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        arcCenter = CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius)
        path.addArc(withCenter: arcCenter, radius: cornerRadius, startAngle: 3 * CGFloat.pi / 2, endAngle: 0, clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius + angleSize))

        // Bottom right corner
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius - angleSize))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        arcCenter = CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius)
        path.addArc(withCenter: arcCenter, radius: cornerRadius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius - angleSize, y: rect.maxY))

        // Bottom left corner
        path.move(to: CGPoint(x: rect.minX + cornerRadius + angleSize, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        arcCenter = CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius)
        path.addArc(withCenter: arcCenter, radius: cornerRadius, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius - angleSize))

        return path
    }


}
