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
        format.dateFormat = "dd"

        let date: Date = Date(timeIntervalSince1970: TimeInterval(self))
        return format.string(from: date)
    }
    func getWeek() -> String {
        let weekArr = ["", "周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        let date: Date = Date(timeIntervalSince1970: TimeInterval(self))
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let component = calendar.component(Calendar.Component.weekday, from: date)
        return weekArr[component]
    }
    func getYearMonthDay() -> String {
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "YYYY/MM/dd"

        let date: Date = Date(timeIntervalSince1970: TimeInterval(self))
        return format.string(from: date)
    }
    func getYearMonth() -> String {
        let format: DateFormatter = DateFormatter()
        format.dateFormat = "YYYY/MM"

        let date: Date = Date(timeIntervalSince1970: TimeInterval(self))
        return format.string(from: date)
    }

    func formatPrice() -> String {
        let format = NumberFormatter()
        format.numberStyle = NumberFormatter.Style.decimal
        let str = format.string(from: NSNumber(value: self))
        return str!
    }
}

extension Float {

    func formatPrice() -> String {
        var str = String(format: "%.2f", self)
        var index = 3
        let length = str.characters.count
        let end = str.endIndex
        while (length-index) > 3 {
            index = index + 3
            str.insert(",", at: str.index(end, offsetBy: -index))
        }
        return str
    }
}

/*
 + (NSString *)formatPrice:(id)price
 {
 NSMutableString *str = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",price]];
 NSRange range = [str rangeOfString:@"."];
 NSInteger index = 0;
 if (range.length) {
 index = range.location;
 } else {
 index = str.length;
 }
 while ((index -3) > 0) {
 index -= 3;
 [str insertString:@"," atIndex:index];
 }
 return str;
 }
 @end
*/

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

