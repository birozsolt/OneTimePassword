//
//  CanvasView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 08/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

final class CanvasView: UIView {
    
    // MARK: - Properties
    
    private lazy var lineWidth: CGFloat = 5
    private lazy var path = UIBezierPath()
    private lazy var helperPath = UIBezierPath()
    private lazy var startingPoint = CGPoint.zero
    private lazy var touchPoint = CGPoint.zero
    private var lineColor: UIColor
    private var helperLineColor: UIColor
    private let helperLayerCounter: Int
    
    private lazy var coordinateList: [Coordinate] = []
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        let isSecure = LocalStorage.shared.getValue(forKey: .secureInput) as? Bool ?? false
        let shouldDraw = LocalStorage.shared.getValue(forKey: .helperLines) as? Bool ?? false
        lineColor = isSecure ? UIColor.clear : AssetCatalog.getColor(.text)
        helperLineColor = isSecure ? UIColor.clear : shouldDraw ? lineColor.withAlphaComponent(0.3) : UIColor.clear
        helperLayerCounter = (Int(LocalStorage.shared.getValue(forKey: .numberOfInput) as? String ?? "1") ?? 1)
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        let isSecure = LocalStorage.shared.getValue(forKey: .secureInput) as? Bool ?? false
        let shouldDraw = LocalStorage.shared.getValue(forKey: .helperLines) as? Bool ?? false
        lineColor = isSecure ? UIColor.clear : AssetCatalog.getColor(.text)
        helperLineColor = isSecure ? UIColor.clear : shouldDraw ? lineColor.withAlphaComponent(0.3) : UIColor.clear
        helperLayerCounter = (Int(LocalStorage.shared.getValue(forKey: .numberOfInput) as? String ?? "1") ?? 1)
        super.init(coder: coder)
    }
    
    // MARK: - View lifecycle
    
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
            
            drawShapeLayer(withColor: lineColor, path: path)
        }
    }
    
    // MARK: - Public methods
    
    func clearCanvas() {
        path.removeAllPoints()
        coordinateList.removeAll()
        if layer.sublayers?.count ?? 0 >= helperLayerCounter {
            layer.sublayers?.removeSubrange(helperLayerCounter..<(layer.sublayers?.count ?? 1))
        }
    }
    
    func clearHelperCanvas() {
        helperPath.removeAllPoints()
        layer.sublayers?.removeSubrange(0..<helperLayerCounter)
    }
    
    func getCoordinateList() -> [Coordinate] {
        return coordinateList
    }
    
    func drawHelper(from coords: [Coordinate]) {
        if !coords.isEmpty {
            helperPath.removeAllPoints()
            helperPath.move(to: CGPoint(x: coords[0].x, y: coords[0].y))
            for coord in coords {
                helperPath.addLine(to: CGPoint(x: coord.x, y: coord.y))
            }
            drawShapeLayer(withColor: helperLineColor, path: helperPath)
        }
    }
    // MARK: - Private methods
    
    private func drawShapeLayer(withColor color: UIColor, path: UIBezierPath) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
        setNeedsDisplay()
    }
}
