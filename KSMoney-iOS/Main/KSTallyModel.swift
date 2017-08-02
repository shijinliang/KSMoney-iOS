//
//  KSTallyModel.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/26.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit
import HandyJSON

class KSTallyModel: HandyJSON {

    let uuid            : String = ""
    let category_id     : Int = 0
    let create_at       : Int = 0
    let remark          : String = ""
    let out_account_id  : Int = 0
    let in_account_id   : Int = 0
    let account_id      : Int = 0
    let price           : Float = 0.00
    let state           : Int = 0

    var category        : Category?
    var out_account     : Account?
    var in_account      : Account?

    var day             : String {
        return self.create_at.getDay()
    }
    var week            : String {
        return self.create_at.getWeek()
    }
    var ymday           : String {
        return self.create_at.getYearMonthDay()
    }
    var month           : String {
        return self.create_at.getYearMonth()
    }

    required init() { }
}


class Category: HandyJSON {
    let name        : String = ""
    let create_at   : Int = 0
    let parent_id   : Int = 0
    let parent_name : String = ""
    required init() { }
}

class Account: HandyJSON {
    let name        : String = ""
    let create_at   : Int = 0
    let image       : String = ""
    let image_tag   : String = ""
    let type        : String = ""
    required init() { }
}
