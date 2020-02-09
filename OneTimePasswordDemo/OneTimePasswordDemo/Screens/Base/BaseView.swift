//
//  BaseView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 08/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class BaseView: UIView {
    
    lazy var firstQuarterView = CanvasView()
    lazy var secondQuarterView = CanvasView()
    lazy var thirdQuarterView = CanvasView()
    lazy var forthQuarterView = CanvasView()
    
    lazy var verticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    lazy var horizontalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    override func layoutSubviews() {
        backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        addSubview(verticalSeparator)
        addSubview(horizontalSeparator)
        
        addSubview(firstQuarterView)
        addSubview(secondQuarterView)
        addSubview(thirdQuarterView)
        addSubview(forthQuarterView)
        setupLayout()
    }
    
    func setupLayout() {
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
        
        forthQuarterView.autoPinEdge(toSuperviewSafeArea: .bottom)
        forthQuarterView.autoPinEdge(toSuperviewSafeArea: .right)
        forthQuarterView.autoPinEdge(.left, to: .right, of: verticalSeparator)
        forthQuarterView.autoPinEdge(.top, to: .bottom, of: horizontalSeparator)
    }
}
