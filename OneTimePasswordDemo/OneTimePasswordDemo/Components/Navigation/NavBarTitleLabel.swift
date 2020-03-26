//
//  NavBarTitleLabel.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class NavBarTitleLabel: UILabel {
    
    // MARK: - Init
    
    init(withTitle title: String?) {
        super.init(frame: CGRect.zero)
        text = title
        setupAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAppearance()
    }
    
    // MARK: - Private methods
    
    private func setupAppearance() {
        font = UIFont.boldSystemFont(ofSize: 30)
        textColor = AssetCatalog.getColor(.buttonBg)
        textAlignment = .center
        clipsToBounds = true
        sizeToFit()
    }
}
