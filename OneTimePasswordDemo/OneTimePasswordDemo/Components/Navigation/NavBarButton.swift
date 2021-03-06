//
//  NavBarButton.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

enum NavBarButtonType: Equatable {
    case back
    case settings
    case eraser
    case save
    case test
    case next
    case text(title: String)
}

final class NavBarButton: UIButton {
    
    // MARK: - Properties
    
    var navBarButtonType: NavBarButtonType
    
    // MARK: - Init
    
    init(withType type: NavBarButtonType) {
        navBarButtonType = type
        super.init(frame: CGRect.zero)
        setNavBar(toType: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setNavBar(toType type: NavBarButtonType) {
        switch type {
        case .back:
            setImage(AssetCatalog.image(.back).scaleWithin(height: 25), for: .normal)
        case .settings:
            setImage(AssetCatalog.image(.settings).scaleWithin(height: 25), for: .normal)
        case .eraser:
            setImage(AssetCatalog.image(.eraser).scaleWithin(height: 25), for: .normal)
        case .save:
            setImage(AssetCatalog.image(.save).scaleWithin(height: 25), for: .normal)
        case .test:
            setImage(AssetCatalog.image(.test).scaleWithin(height: 25), for: .normal)
        case .next:
            setImage(AssetCatalog.image(.next).scaleWithin(height: 25), for: .normal)
        case .text(let title):
            setTitle(title, for: .normal)
            setTitleColor(AssetCatalog.color(.buttonBg), for: .normal)
            titleLabel?.adjustsFontSizeToFitWidth = true
        }
        contentMode = .scaleAspectFit
    }
}
