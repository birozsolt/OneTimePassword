//
//  CanvasView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 08/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class CanvasView: UIView {
    
    // MARK: - Properties
    
    private lazy var lineWidth: CGFloat = 5
    private lazy var path = UIBezierPath()
    private lazy var helperPath = UIBezierPath()
    private lazy var startingPoint = CGPoint.zero
    private var lineColor: UIColor
    private var helperLineColor: UIColor
    private var helperLayerCounter: Int
    private let shouldDraw: Bool
    
    private lazy var coordinateList: [Coordinate] = []
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        let isSecure = LocalStorage.getBoolValue(forKey: .secureInput)
        shouldDraw = LocalStorage.getBoolValue(forKey: .helperLines)
        lineColor = isSecure ? UIColor.clear : AssetCatalog.color(.text)
        helperLineColor = isSecure ? UIColor.clear : shouldDraw ? lineColor.withAlphaComponent(0.3) : UIColor.clear
        helperLayerCounter = shouldDraw ? LocalStorage.getIntValue(forKey: .numberOfInput) : 0
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        let isSecure = LocalStorage.getBoolValue(forKey: .secureInput)
        shouldDraw = LocalStorage.getBoolValue(forKey: .helperLines)
        lineColor = isSecure ? UIColor.clear : AssetCatalog.color(.text)
        helperLineColor = isSecure ? UIColor.clear : shouldDraw ? lineColor.withAlphaComponent(0.3) : UIColor.clear
        helperLayerCounter = shouldDraw ? LocalStorage.getIntValue(forKey: .numberOfInput) : 0
        super.init(coder: coder)
    }
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        backgroundColor = AssetCatalog.color(.background)
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
        let xRange = 0...frame.size.width
        let yRange = 0...frame.size.height
        if xRange.contains(location.x) && yRange.contains(location.y) {
            coordinateList.append(Coordinate(x: location.x,
                                             y: location.y,
                                             force: touch.force))
            path.move(to: startingPoint)
            path.addLine(to: location)
            startingPoint = location
            
            drawShapeLayer(withColor: lineColor, path: path)
        }
    }
    
    // MARK: - Public methods
    
    func clearCanvas() {
        guard let layerCount = layer.sublayers?.count, layerCount >= helperLayerCounter else {
            return
        }
        coordinateList.removeAll()
        DispatchQueue.main.async {
            self.path.removeAllPoints()
            self.layer.sublayers?.removeSubrange(self.helperLayerCounter..<layerCount)
        }
    }
    
    func clearHelperCanvas() {
        DispatchQueue.main.async {
            self.helperPath.removeAllPoints()
            self.layer.sublayers?.removeSubrange(0..<self.helperLayerCounter)
        }
    }
    
    func getCoordinateList() -> [Coordinate] {
        return coordinateList
    }
    
    func drawHelper(from coords: [Coordinate], helperCount: Int) {
        guard !coords.isEmpty, let firstX = coords.first?.x, let firstY = coords.first?.y else {
            return
        }
        helperLayerCounter = shouldDraw ? helperCount : 0
        helperPath.removeAllPoints()
        helperPath.move(to: CGPoint(x: firstX, y: firstY))
        for coord in coords {
            helperPath.addLine(to: CGPoint(x: coord.x, y: coord.y))
        }
        drawShapeLayer(withColor: helperLineColor, path: helperPath)
        
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
