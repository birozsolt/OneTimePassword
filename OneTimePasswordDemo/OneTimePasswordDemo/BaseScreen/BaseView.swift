//
//  BaseView.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 08/02/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import PureLayout

class BaseView: UIView {
    
    lazy var firstQuarterView = QuarterView()
    lazy var secondQuarterView = QuarterView()
    lazy var thirdQuarterView = QuarterView()
    lazy var forthQuarterView = QuarterView()
    
    lazy var verticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var horizontalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var firstTouch = CGPoint()
    lazy var nextTouch = CGPoint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        verticalSeparator.autoAlignAxis(toSuperviewAxis: .vertical)
        verticalSeparator.autoPinEdge(toSuperviewEdge: .top)
        verticalSeparator.autoPinEdge(toSuperviewEdge: .bottom)
        verticalSeparator.autoSetDimension(.width, toSize: 1)
        
        horizontalSeparator.autoAlignAxis(toSuperviewAxis: .horizontal)
        horizontalSeparator.autoPinEdge(toSuperviewEdge: .left)
        horizontalSeparator.autoPinEdge(toSuperviewEdge: .right)
        horizontalSeparator.autoSetDimension(.height, toSize: 1)
        
        firstQuarterView.autoPinEdge(toSuperviewEdge: .top)
        firstQuarterView.autoPinEdge(toSuperviewEdge: .left)
        firstQuarterView.autoPinEdge(.right, to: .left, of: verticalSeparator)
        firstQuarterView.autoPinEdge(.bottom, to: .top, of: horizontalSeparator)
        
        secondQuarterView.autoPinEdge(toSuperviewEdge: .top)
        secondQuarterView.autoPinEdge(toSuperviewEdge: .right)
        secondQuarterView.autoPinEdge(.left, to: .right, of: verticalSeparator)
        secondQuarterView.autoPinEdge(.bottom, to: .top, of: horizontalSeparator)
        
        thirdQuarterView.autoPinEdge(toSuperviewEdge: .bottom)
        thirdQuarterView.autoPinEdge(toSuperviewEdge: .left)
        thirdQuarterView.autoPinEdge(.right, to: .left, of: verticalSeparator)
        thirdQuarterView.autoPinEdge(.top, to: .bottom, of: horizontalSeparator)
        
        forthQuarterView.autoPinEdge(toSuperviewEdge: .bottom)
        forthQuarterView.autoPinEdge(toSuperviewEdge: .right)
        forthQuarterView.autoPinEdge(.left, to: .right, of: verticalSeparator)
        forthQuarterView.autoPinEdge(.top, to: .bottom, of: horizontalSeparator)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let firstTouch = touches.first else { return }
        let hitView = self.hitTest(firstTouch.location(in: self), with: event)
        if hitView == firstQuarterView {
            self.firstTouch = firstTouch.location(in: firstQuarterView)
            print("touchesBegan 1Q: ", firstTouch.location(in: firstQuarterView))
        }
        if hitView == secondQuarterView {
            self.firstTouch = firstTouch.location(in: secondQuarterView)
            print("touchesBegan 2Q: ", firstTouch.location(in: secondQuarterView))
        }
        if hitView == thirdQuarterView {
            self.firstTouch = firstTouch.location(in: thirdQuarterView)
            print("touchesBegan 3Q: ", firstTouch.location(in: thirdQuarterView))
        }
        if hitView == forthQuarterView {
            self.firstTouch = firstTouch.location(in: forthQuarterView)
            print("touchesBegan 4Q: ", firstTouch.location(in: forthQuarterView))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let firstTouch = touches.first else { return }
        let hitView = self.hitTest(firstTouch.location(in: self), with: event)
        if hitView == firstQuarterView {
            print("touchesMoved 1Q: ", firstTouch.location(in: firstQuarterView))
        }
        if hitView == secondQuarterView {
            print("touchesMoved 2Q: ", firstTouch.location(in: secondQuarterView))
        }
        if hitView == thirdQuarterView {
            print("touchesMoved 3Q: ", firstTouch.location(in: thirdQuarterView))
        }
        if hitView == forthQuarterView {
            print("touchesMoved 4Q: ", firstTouch.location(in: forthQuarterView))
        }
    }
}
