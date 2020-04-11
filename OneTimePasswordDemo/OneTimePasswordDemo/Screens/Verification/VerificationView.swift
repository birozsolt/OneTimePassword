//
//  VerificationView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 08/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

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
        resetBorderColor()
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
    
    func changeBorderColor(forQuarter quarter: Quarters, _ isGood: Bool) {
        let color = isGood ? AssetCatalog.getColor(.goodVerification) : AssetCatalog.getColor(.wrongVerification)
        switch quarter {
        case .first:
            firstQuarterView.layer.borderColor = color.cgColor
        case .second:
            secondQuarterView.layer.borderColor = color.cgColor
        case .third:
            thirdQuarterView.layer.borderColor = color.cgColor
        case .fourth:
            fourthQuarterView.layer.borderColor = color.cgColor
        }
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        addSubview(firstQuarterView)
        addSubview(secondQuarterView)
        addSubview(thirdQuarterView)
        addSubview(fourthQuarterView)
        setupLayoutConstraints()
    }
    
    private func setupLayoutConstraints() {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.borderColor = AssetCatalog.getColor(.buttonBg).cgColor
            $0.layer.borderWidth = 1
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                $0.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                $0.widthAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.width / 4)
            ])
        }
        
        NSLayoutConstraint.activate([
            firstQuarterView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            secondQuarterView.leadingAnchor.constraint(equalTo: firstQuarterView.trailingAnchor),
            thirdQuarterView.leadingAnchor.constraint(equalTo: secondQuarterView.trailingAnchor),
            fourthQuarterView.leadingAnchor.constraint(equalTo: thirdQuarterView.trailingAnchor)
        ])
    }
    
    private func resetBorderColor() {
        subviews.forEach { $0.layer.borderColor = AssetCatalog.getColor(.buttonBg).cgColor }
    }
}
