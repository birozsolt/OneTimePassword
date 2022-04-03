//
//  OTPButton.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 23/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class OTPButton: UIButton {
    
    // MARK: - Init
    
    init(withTitle title: String) {
        super.init(frame: CGRect.zero)
        setupAppearance(title: title)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private methods
    
    private func setupAppearance(title: String) {
        backgroundColor = AssetCatalog.color(.buttonBg)
        setTitle(title, for: .normal)
        setTitleColor(AssetCatalog.color(.buttonTitle), for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 20)
        layer.cornerRadius = 20
    }
}
