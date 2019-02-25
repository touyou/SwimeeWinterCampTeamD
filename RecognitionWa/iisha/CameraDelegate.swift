//
//  CameraDelegate.swift
//  iisha
//
//  Created by 張翔 on 2018/12/29.
//  Copyright © 2018 張翔. All rights reserved.
//

import Foundation
import UIKit

protocol CameraDelegate: class {
    func photoOutput(_ image: UIImage)
}
