//
//  AdManager.swift
//  iisha
//
//  Created by 張翔 on 2018/12/28.
//  Copyright © 2018 張翔. All rights reserved.
//

import Foundation

class AdManager {
    static let appID = "ca-app-pub-8584614776087034~7925054882"
    #if DEBUG
    static let cameraBannerID = "ca-app-pub-3940256099942544/2934735716"
    static let resultBannerID = "ca-app-pub-3940256099942544/2934735716"
    #else
    static let cameraBannerID = "ca-app-pub-8584614776087034/1390548074"
    static let resultBannerID = "ca-app-pub-8584614776087034/5341471182"
    #endif
}
