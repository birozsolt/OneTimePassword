//
//  VerificationView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 08/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class VerificationView: UIView {
    
    private lazy var firstQuarterView = CanvasView()
    private lazy var secondQuarterView = CanvasView()
    private lazy var thirdQuarterView = CanvasView()
    private lazy var fourthQuarterView = CanvasView()
    
    enum Quarters: String {
        case first
        case second
        case third
        case fourth
    }
    
    private lazy var verticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var horizontalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    override func layoutSubviews() {
        backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        addSubview(verticalSeparator)
        addSubview(horizontalSeparator)
        
        addSubview(firstQuarterView)
        addSubview(secondQuarterView)
        addSubview(thirdQuarterView)
        addSubview(fourthQuarterView)
        setupLayout()
    }
    
    private func setupLayout() {
        verticalSeparator.autoAlignAxis(toSuperviewMarginAxis: .vertical)
        verticalSeparator.autoPinEdge(toSuperviewSafeArea: .top)
        verticalSeparator.autoPinEdge(toSuperviewSafeArea: .bottom)
        verticalSeparator.autoSetDimension(.width, toSize: 2)
        
        horizontalSeparator.autoAlignAxis(toSuperviewMarginAxis: .horizontal)
        horizontalSeparator.autoPinEdge(toSuperviewSafeArea: .left)
        horizontalSeparator.autoPinEdge(toSuperviewSafeArea: .right)
        horizontalSeparator.autoSetDimension(.height, toSize: 2)
        
        firstQuarterView.autoPinEdge(toSuperviewSafeArea: .top)
        firstQuarterView.autoPinEdge(toSuperviewSafeArea: .left)
        firstQuarterView.autoPinEdge(.right, to: .left, of: verticalSeparator)
        firstQuarterView.autoPinEdge(.bottom, to: .top, of: horizontalSeparator)
        
        secondQuarterView.autoPinEdge(toSuperviewSafeArea: .top)
        secondQuarterView.autoPinEdge(toSuperviewSafeArea: .right)
        secondQuarterView.autoPinEdge(.left, to: .right, of: verticalSeparator)
        secondQuarterView.autoPinEdge(.bottom, to: .top, of: horizontalSeparator)
        
        thirdQuarterView.autoPinEdge(toSuperviewSafeArea: .bottom)
        thirdQuarterView.autoPinEdge(toSuperviewSafeArea: .left)
        thirdQuarterView.autoPinEdge(.right, to: .left, of: verticalSeparator)
        thirdQuarterView.autoPinEdge(.top, to: .bottom, of: horizontalSeparator)
        
        fourthQuarterView.autoPinEdge(toSuperviewSafeArea: .bottom)
        fourthQuarterView.autoPinEdge(toSuperviewSafeArea: .right)
        fourthQuarterView.autoPinEdge(.left, to: .right, of: verticalSeparator)
        fourthQuarterView.autoPinEdge(.top, to: .bottom, of: horizontalSeparator)
    }
    
    private func getCoordinates(forQuarter quarter: Quarters) -> [Coordinate] {
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
    
    func getAllCoordinates() -> CoordinateModel {
        let coordinateModel = CoordinateModel(coordsQ1: getCoordinates(forQuarter: .first),
                                              coordsQ2: getCoordinates(forQuarter: .second),
                                              coordsQ3: getCoordinates(forQuarter: .third),
                                              coordsQ4: getCoordinates(forQuarter: .fourth))
        return coordinateModel
    }
    
    func clearCanvas() {
        firstQuarterView.clearCanvas()
        secondQuarterView.clearCanvas()
        thirdQuarterView.clearCanvas()
        fourthQuarterView.clearCanvas()
    }
}
