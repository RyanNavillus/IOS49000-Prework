//
//  UIColor + TippyColor.swift
//  tippy
//
//  Created by Ryan Sullivan on 1/9/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    private static let tintSampleView = UIView()
    
    static let lightTintColor = tintSampleView.tintColor
    static let lightPrimaryBackgroundColor = UIColor.white
    static let lightSecondaryBackgroundColor = UIColor(red: 238, green: 238, blue: 238)
    static let lightTextColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)

    static let darkTintColor = UIColor(red: 115, green: 245, blue: 115)
    static let darkPrimaryBackgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
    static let darkSecondaryBackgroundColor = UIColor.darkGray
    static let darkTextColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    

    
}
