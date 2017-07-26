//
//  KSInterFace.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/24.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit

//public let ApiHost          = "http://kamy.walkinglove.com:8080/"
public let ApiHost          = "http://127.0.0.1:8080/"
public let ApiLogin         = "api/v1/signin"
public let ApiRegister      = "api/v1/signup"
public let ApiTally         = "api/v1/tally"
public let ApiAllTally      = "api/v1/tallys"

class KSInterFace: NSObject {

}

extension NSString {
    func tokenUrl() -> String {
        return ApiHost+(self as String)
    }
}
