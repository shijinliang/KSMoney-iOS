//
//  AppTool.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/24.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

public let AppWidth         = UIScreen.main.bounds.size.width
public let AppHeight        = UIScreen.main.bounds.size.height
public let AppNavHeight     = 64
public let AppBottomHeight  = 49
public let KSAnimationTime  = 0.25
public let KSShadowRadius   = 10

public let ColorMain        = UIColor(hex: "FF6710")
public let ColorGray        = UIColor(hex: "8A8A8A")
public let ColorTransfer    = UIColor(hex: "00B5FF")
public let ColorIncome      = UIColor(hex: "FF6710")
public let ColorExpend      = UIColor(hex: "999999")
class AppTool : NSObject {

}

extension DefaultsKeys {
    static let token = DefaultsKey<String?>("token")
    static let loginModel = DefaultsKey<KSLoginModel?>("loginModel")
}
