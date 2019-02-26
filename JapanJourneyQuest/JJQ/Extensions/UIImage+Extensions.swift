//
//  UIImageView+Extensions.swift
//  JJQ
//
//  Created by 張翔 on 2019/02/26.
//  Copyright © 2019 Swimee Winter Camp 2019 Manager. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    struct Gems {
        static let jewel0 = #imageLiteral(resourceName: "jewel_dia_1")
        static let jewel1 = #imageLiteral(resourceName: "jewel_cdia_1")
        static let jewel2 = #imageLiteral(resourceName: "jewel_hex_1")
        static let jewel3 = #imageLiteral(resourceName: "jewel_rect_2")
        static let jewel4 = #imageLiteral(resourceName: "jewel_dia_gray")
        static let jewel5 = #imageLiteral(resourceName: "jewel_long_hex_1")
        static let jewel6 = #imageLiteral(resourceName: "jewel_long_hex_2")
        static let jewel7 = #imageLiteral(resourceName: "jewel_star_2")
        static let jewel8 = #imageLiteral(resourceName: "jewel_rect_gray")
        static let jewel9 = #imageLiteral(resourceName: "jewel_hex_gray")
        static let jewel10 = #imageLiteral(resourceName: "jewel_rect_1")
        static let jewel11 = #imageLiteral(resourceName: "jewel_dia_2")
    }
    
    static func gemImage(_ id: Int) -> UIImage{
        switch id {
        case 0: return Gems.jewel0
        case 1: return Gems.jewel1
        case 2: return Gems.jewel2
        case 3: return Gems.jewel3
        case 4: return Gems.jewel4
        case 5: return Gems.jewel5
        case 6: return Gems.jewel6
        case 7: return Gems.jewel7
        case 8: return Gems.jewel8
        case 9: return Gems.jewel9
        case 10: return Gems.jewel10
        case 11: return Gems.jewel11
        default: return Gems.jewel0
        }
    }
}
