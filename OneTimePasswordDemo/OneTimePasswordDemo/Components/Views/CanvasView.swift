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
    private var lineColor: UIColor
    private lazy var path = UIBezierPath()
    private lazy var startingPoint = CGPoint.zero
    private lazy var touchPoint = CGPoint.zero
    
    private lazy var coordinateList: [Coordinate] = []
    
    init() {
        let isSecure = LocalStorage.shared.getValue(forKey: .secureInput) as? Bool ?? false
        lineColor = isSecure ? UIColor.clear : AssetCatalog.getColor(.text)
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = AssetCatalog.getColor(.background)
        isMultipleTouchEnabled = false
        clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        startingPoint = touch.location(in: self)
        coordinateList.append(Coordinate(x: startingPoint.x,
                                         y: startingPoint.y,
                                         force: touch.force))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let maxX = frame.size.width
        let maxY = frame.size.height
        if location.x < maxX && location.x > 0 && location.y < maxY && location.y > 0 {
            touchPoint = location
            coordinateList.append(Coordinate(x: touchPoint.x,
                                             y: touchPoint.y,
                                             force: touch.force))
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
    
    func clearCanvas() {
        path.removeAllPoints()
        layer.sublayers?.removeAll()
    }
    
    func getCoordinateList() -> [Coordinate] {
        return coordinateList
    }
}
