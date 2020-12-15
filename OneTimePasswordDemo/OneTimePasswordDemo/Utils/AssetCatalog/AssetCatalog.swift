//
//  AssetCatalog.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 23/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

final class AssetCatalog: NSObject {
    enum ImageCatalog: String {
        case back
        case settings
        case eraser
        case save
        case test
        case next
    }
    
    enum ColorCatalog: String {
        case background
        case buttonTitle
        case buttonBg
        case text
        case textfieldBg
        case goodVerification
        case wrongVerification
    }
    
    private override init() { }
    
    static func image(_ name: ImageCatalog) -> UIImage {
        return UIImage(named: name.rawValue) ?? UIImage()
    }
    
    static func color(_ name: ColorCatalog) -> UIColor {
        return UIColor(named: name.rawValue) ?? UIColor.black
    }
}
