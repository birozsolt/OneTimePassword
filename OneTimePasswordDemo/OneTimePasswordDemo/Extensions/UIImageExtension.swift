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
        return resizedImage(newSize: newSize)
    }
    
    /// Returns an image that fills in newSize
    private func resizedImage(newSize: CGSize) -> UIImage? {
        guard size != newSize else { return self }
        let renderFormat = UIGraphicsImageRendererFormat.default()
        let renderer = UIGraphicsImageRenderer(size: newSize, format: renderFormat)
        let newImage = renderer.image { _ in
            self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        }
        return newImage
    }
}
