//
//  NavBarButton.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

enum NavBarButtonType {
    case back
    case settings
}
class NavBarButton: UIButton {
    
    // MARK: - Properties
    
    var navBarButtonType: NavBarButtonType?
    
    // MARK: - Init
    
    init(withType type: NavBarButtonType) {
        super.init(frame: CGRect.zero)
        navBarButtonType = type
        switch type {
        case .back:
            setImage(AssetCatalog.getImage(.back).scaleWithin(height: 30), for: .normal)
        case .settings:
            setImage(AssetCatalog.getImage(.settings).scaleWithin(height: 30), for: .normal)
        }
        contentMode = .scaleAspectFit
    }
    
    init(withTitle title: String = "") {
        super.init(frame: CGRect.zero)
        setTitle(title, for: .normal)
        tintColor = AssetCatalog.getColor(.buttonTitle)
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
