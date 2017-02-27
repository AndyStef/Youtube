//
//  UIColor.swift
//  Youtube
//
//  Created by Andy Stef on 2/27/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r: Float, g: Float, b: Float) {
        self.init(colorLiteralRed: r / 255, green: g / 255, blue: b / 255, alpha: 1.0)
    }
}
