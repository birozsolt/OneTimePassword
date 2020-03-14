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
    var navBarButtonType: NavBarButtonType?
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    init(withType type: NavBarButtonType) {
        super.init(frame: CGRect.zero)
        navBarButtonType = type
        switch type {
        case .back:
            setImage(UIImage(named: "back")?.scaleWithin(height: 30), for: .normal)
        case .settings:
            setImage(UIImage(named: "settings")?.scaleWithin(height: 30), for: .normal)
        }
        contentMode = .scaleAspectFit
    }
    
    init(withTitle title: String) {
        super.init(frame: CGRect.zero)
        setTitle(title, for: .normal)
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
