//
//  KamyExtension.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/31.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit


public extension UITableViewCell {
    class func cell(tableView: UITableView) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(self))
        if cell == nil {
            cell = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as? UITableViewCell
        }
        return cell!
    }
    
    class func cellWithTableView<T: UITableViewCell>(_ tableView: UITableView) -> T {
        var cell = tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? T
        if cell == nil {
            cell = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as? T
        }
        return cell!
    }
}


extension UIView {

    class func fromNib<T: UIView>() -> T? {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? T
    }
}

extension Int {
    func getDay() -> String {
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "YYYY/MM/dd"

        let date: Date = Date(timeIntervalSince1970: TimeInterval(self))
        return format.string(from: date)
    }
    func getMonth() -> String {
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "YYYY/MM"

        let date: Date = Date(timeIntervalSince1970: TimeInterval(self))
        return format.string(from: date)
    }
}

extension String {
    func isToday() -> Bool {
        let now: Int = Int(Date().timeIntervalSinceNow)
        return self == now.getDay()
    }
    func isYesterday() -> Bool {
        var yes: Int = Int(Date().timeIntervalSinceNow)
        yes = yes - 3600*24
        return self == yes.getDay()
    }
}

