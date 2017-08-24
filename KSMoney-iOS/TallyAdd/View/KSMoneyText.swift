//
//  KSMoneyText.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/8/2.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit
import SnapKit

class KSMoneyText: UIView, UITextFieldDelegate, KSMoneyKeyBoardDelegate {

    var tempStr: String = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorExpend
        addSubview(tipLabel)
        addSubview(priceText)
        tipLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        priceText.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
            make.left.equalTo(tipLabel.snp.right).offset(20)
        }

        priceText.inputView = moneyKeyBoard
        priceText.becomeFirstResponder()

        NotificationCenter.default.addObserver(self, selector: #selector(KSMoneyText.textChange(_:)), name: Notification.Name.UITextFieldTextDidChange, object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func textChange(_ not: Notification) {
        let text = (not.object as! UITextField)
        if text == priceText && (priceText.text?.isTwoDecimal())! {
            print("可以")
        } else {
            print("不可以")
            //let index = priceText.text?.index((priceText.text?.endIndex)!, offsetBy: -1)
            //priceText.text = priceText.text?.substring(to: index!)
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oStr: NSString = NSString(format: "%@", textField.text!)
        let str = oStr.replacingCharacters(in: range, with: oStr as String)

        if str.isTwoDecimal() {
            return true
        }
        return false
    }
    //MARK: 🐔 KSMoneyKeyBoardDelegate
    func addNum(_ num: Int) {
        let str = priceText.text!+"\(num)"
        if (!str.isTwoDecimal()) {
            return
        }
        priceText.text?.append("\(num)")
    }
    func addPoint() {
        let str = priceText.text
        if (str?.contains("."))! {
            return
        }
        priceText.text?.append(".")
    }
    func deleteNum() {
        priceText.deleteBackward()
    }
    func switchType(_ type: TallyType) {
        switch type {
        case .expend:
            self.tipLabel.text = "支出"
            self.backgroundColor = ColorExpend
            break
        case .income:
            self.tipLabel.text = "收入"
            self.backgroundColor = ColorIncome
            break
        case .transfer:
            self.tipLabel.text = "转账"
            self.backgroundColor = ColorTransfer
            break
        default: break

        }
    }

    func setType(_ type: TallyType) {
        switchType(type)
        moneyKeyBoard.setTypeBtn(type)
    }

    //MARK: 🐔 懒加载
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()

    lazy var priceText: UITextField = {
        let text = UITextField()
        text.placeholder = "0.00"
        text.font = UIFont.systemFont(ofSize: 30)
        text.textColor = UIColor.white
        text.textAlignment = NSTextAlignment.right
        text.delegate = self
        return text
    }()

    lazy var moneyKeyBoard: KSMoneyKeyBoard = {
        let keyBoard = KSMoneyKeyBoard(frame: CGRect(x: 0, y: Int(AppHeight)-180, width: Int(AppWidth), height: 180))
        keyBoard.delegate = self
        return keyBoard
    }()
}
