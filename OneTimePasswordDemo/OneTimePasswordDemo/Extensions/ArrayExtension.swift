//
//  ArrayExtension.swift
//  OneTimePasswordDemo
//
//  Created by Biro Zsolt on 31/03/2020.
//  Copyright © 2020 Biro Zsolt. All rights reserved.
//

import Foundation

extension Array where Element: FloatingPoint {
    
    private var min: Element {
        return self.min() ?? 0
    }
    
    private var max: Element {
        return self.max() ?? 0
    }
    
    mutating func normalized() -> Array {
        return map { ($0 - min) / (max - min) }
    }
    
    mutating func restored(min: Element, max: Element) -> Array {
        return map { ($0 * (max - min) + min) }
    }
}
