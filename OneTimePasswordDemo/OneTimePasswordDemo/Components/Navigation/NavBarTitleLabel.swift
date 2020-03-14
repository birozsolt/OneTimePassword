//
//  NavBarTitleLabel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

class NavBarTitleLabel: UILabel {

    init(withTitle title: String?) {
        super.init(frame: CGRect.zero)
        text = title
        font = UIFont.boldSystemFont(ofSize: 30)
        textColor = .darkGray
        textAlignment = .center
        clipsToBounds = true
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
