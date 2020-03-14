//
//  UIImageExtension.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 14/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import UIKit

extension UIImage {
    /// Returns a resized image that fits in height, keeping it's aspect ratio
    public func scaleWithin(height: CGFloat) -> UIImage? {
        let scale = height / size.height
        let newSize = CGSize(width: size.width * scale, height: height)
        let resized = resizedImage(newSize: newSize)
        return resized
    }
    
    /// Returns an image that fills in newSize
    private func resizedImage(newSize: CGSize) -> UIImage? {
        guard size != newSize else { return self }
        let hasAlpha = false
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(newSize, !hasAlpha, scale)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
