//
//  VerificationView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 08/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

enum Quarters: String {
    case first
    case second
    case third
    case fourth
}

final class VerificationView: UIView {
    
    // MARK: - Properties
    
    private lazy var firstQuarterView = CanvasView()
    private lazy var secondQuarterView = CanvasView()
    private lazy var thirdQuarterView = CanvasView()
    private lazy var fourthQuarterView = CanvasView()
    
    // MARK: - View lifecycle
    
    override func layoutSubviews() {
        backgroundColor = AssetCatalog.getColor(.background)
        setupView()
    }
    
    // MARK: - Public methods
    
    func getCoordinates(forQuarter quarter: Quarters) -> [Coordinate] {
        switch quarter {
        case .first:
            return firstQuarterView.getCoordinateList()
        case .second:
            return secondQuarterView.getCoordinateList()
        case .third:
            return thirdQuarterView.getCoordinateList()
        case .fourth:
            return fourthQuarterView.getCoordinateList()
        }
    }
    
    func clearCanvas() {
        firstQuarterView.clearCanvas()
        secondQuarterView.clearCanvas()
        thirdQuarterView.clearCanvas()
        fourthQuarterView.clearCanvas()
    }
    
    func drawHelpers(forQuarter quarter: Quarters, from coords: [Coordinate]) {
        switch quarter {
        case .first:
            firstQuarterView.drawHelper(from: coords)
        case .second:
            secondQuarterView.drawHelper(from: coords)
        case .third:
            thirdQuarterView.drawHelper(from: coords)
        case .fourth:
            fourthQuarterView.drawHelper(from: coords)
        }
        
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        addSubview(firstQuarterView)
        addSubview(secondQuarterView)
        addSubview(thirdQuarterView)
        addSubview(fourthQuarterView)
        setupLayout()
    }
    
    private func setupLayout() {
        let quarterWidth = self.safeAreaLayoutGuide.layoutFrame.width / 4
        
        firstQuarterView.autoPinEdge(toSuperviewSafeArea: .left) 
        secondQuarterView.autoPinEdge(.left, to: .right, of: firstQuarterView)
        thirdQuarterView.autoPinEdge(.left, to: .right, of: secondQuarterView)
        fourthQuarterView.autoPinEdge(.left, to: .right, of: thirdQuarterView)
        
        for view in subviews {
            view.autoPinEdge(toSuperviewSafeArea: .top)
            view.autoPinEdge(toSuperviewSafeArea: .bottom)
            view.autoSetDimension(.width, toSize: quarterWidth)
            view.layer.borderColor = AssetCatalog.getColor(.buttonBg).cgColor
            view.layer.borderWidth = 1
        }
    }
}
