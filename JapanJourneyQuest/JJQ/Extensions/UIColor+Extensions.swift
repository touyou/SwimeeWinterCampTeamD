//
//  UIColor+Extensions.swift
//  
//
//  Created by 藤井陽介 on 2019/02/26.
//

import UIKit

extension UIColor {
    struct JJQ {
        static let main = UIColor(hex: "#ff6666")
        static let black = UIColor(hex: "#170c08")
        static let base = UIColor(hex: "#ebebeb")
    }
}

// MARK: - Initialization Extensions

extension UIColor {

    convenience init(hex: String) {

        let colorString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased().filter { "#" != $0 }
        let alpha: CGFloat = colorString.count == 6 ? 1.0 : 0.0
        var rgb: UInt32 = 0
        Scanner(string: colorString).scanHexInt32(&rgb)

        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: alpha)
    }
}
