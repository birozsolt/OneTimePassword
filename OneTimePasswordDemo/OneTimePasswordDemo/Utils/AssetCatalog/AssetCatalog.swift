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
    }
    
    enum ColorCatalog: String {
        case background
        case buttonTitle
        case buttonBg
        case text
        case textfieldBg
    }
    
    private override init() {
    }
    
    static func getImage(_ name: ImageCatalog) -> UIImage {
        return UIImage(named: name.rawValue) ?? UIImage()
    }
    
    static func getColor(_ name: ColorCatalog) -> UIColor {
        return UIColor(named: name.rawValue) ?? UIColor.black
    }
}
