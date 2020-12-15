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
        backgroundColor = AssetCatalog.color(.background)
        setupView()
    }
    
    // MARK: - Public methods
    
    func getCoordinates() -> CoordinateGroup {
        return (q1: firstQuarterView.getCoordinateList(),
                q2: secondQuarterView.getCoordinateList(),
                q3: thirdQuarterView.getCoordinateList(),
                q4: fourthQuarterView.getCoordinateList())
    }
    
    func clearCanvas() {
        firstQuarterView.clearCanvas()
        secondQuarterView.clearCanvas()
        thirdQuarterView.clearCanvas()
        fourthQuarterView.clearCanvas()
        resetBorderColor()
    }
    
    func drawHelpers(for model: CoordinateModel, sampleCount: Int) {
        firstQuarterView.drawHelper(from: model.getSerie(forQuarter: .first).getCoordinates(), helperCount: sampleCount)
        secondQuarterView.drawHelper(from: model.getSerie(forQuarter: .second).getCoordinates(), helperCount: sampleCount)
        thirdQuarterView.drawHelper(from: model.getSerie(forQuarter: .third).getCoordinates(), helperCount: sampleCount)
        fourthQuarterView.drawHelper(from: model.getSerie(forQuarter: .fourth).getCoordinates(), helperCount: sampleCount)
    }
    
    func changeBorderColor(for results: [Bool]) {
        func getColor(_ isTrue: Bool) -> CGColor {
            return isTrue ? AssetCatalog.color(.goodVerification).cgColor : AssetCatalog.color(.wrongVerification).cgColor
        }
        
        firstQuarterView.layer.borderColor = getColor(results[0])
        secondQuarterView.layer.borderColor = getColor(results[1])
        thirdQuarterView.layer.borderColor = getColor(results[2])
        fourthQuarterView.layer.borderColor = getColor(results[3])
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
            $0.layer.borderColor = AssetCatalog.color(.buttonBg).cgColor
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
        subviews.forEach { $0.layer.borderColor = AssetCatalog.color(.buttonBg).cgColor }
    }
}
