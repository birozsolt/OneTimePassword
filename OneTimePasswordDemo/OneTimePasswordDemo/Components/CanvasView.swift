//
//  CanvasView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 08/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class CanvasView: UIView {
    private lazy var lineWidth: CGFloat = 5
    private lazy var lineColor = UIColor.black
    private lazy var path = UIBezierPath()
    private lazy var startingPoint = CGPoint.zero
    private lazy var touchPoint = CGPoint.zero
    
    override func layoutSubviews() {
        backgroundColor = .white
        isMultipleTouchEnabled = false
        clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        startingPoint = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let maxX = self.frame.size.width
        let maxY = self.frame.size.height
        if location.x < maxX && location.x > 0 && location.y < maxY && location.y > 0 {
            touchPoint = location
            path.move(to: startingPoint)
            path.addLine(to: touchPoint)
            startingPoint = touchPoint
            
            drawShapeLayer()
        }
    }
    
    private func drawShapeLayer() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
        setNeedsDisplay()
    }
}
