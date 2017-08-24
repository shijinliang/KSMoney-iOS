//
//  KSMoneyKeyBoard.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/8/2.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit
import SnapKit

enum TallyType: Int {
    case expend = 1
    case income = 2
    case transfer = 3
}

protocol KSMoneyKeyBoardDelegate {
    func switchType(_ type: TallyType) -> Void
    func deleteNum() -> Void
    func addNum(_ num: Int) -> Void
    func addPoint() -> Void
}

class KSMoneyKeyBoard: UIView {

    open var delegate: KSMoneyKeyBoardDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        addSubview(typeView)
        addSubview(calculatorView)
        typeView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(30)
        }

        calculatorView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(typeView.snp.right).offset(1)
        }

        setUI()
    }

    func setUI() {
        let btn1: UIButton = self.createTypeButton(tag: 21, title: "支\n出")
        let btn2: UIButton = self.createTypeButton(tag: 22, title: "收\n入")
        let btn3: UIButton = self.createTypeButton(tag: 23, title: "转\n账")
        typeView.addSubview(btn1)
        typeView.addSubview(btn2)
        typeView.addSubview(btn3)
        btn1.snp.makeConstraints({ (make) in
            make.top.left.right.equalToSuperview()

        })
        btn2.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(btn1.snp.height)
            make.top.equalTo(btn1.snp.bottom).offset(1)
        })
        btn3.snp.makeConstraints({ (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(btn2.snp.height)
            make.top.equalTo(btn2.snp.bottom).offset(1)
        })

        for i in 1...12 {
            let btn: UIButton = viewWithTag(i) as! UIButton
            btn.backgroundColor = UIColor.gray
            btn.addTarget(self, action: #selector(KSMoneyKeyBoard.clickCalculator(_:)), for: UIControlEvents.touchUpInside)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setTypeBtn(_ type: TallyType) {
        let btn: UIButton = viewWithTag(type.rawValue+20) as! UIButton
        btn.backgroundColor = UIColor.lightGray
    }
    func clickTypeBtn(_ sender: UIButton) {
        resetTypeBtn()
        sender.backgroundColor = UIColor.lightGray

        self.delegate?.switchType(TallyType(rawValue: sender.tag-20)!)
    }
    func clickCalculator(_ sender: UIButton) {
        if sender.tag > 0 && sender.tag < 11 {
            self.delegate?.addNum(sender.tag%10)
        } else if sender.tag == 11 {
            self.delegate?.addPoint()
        } else {
            self.delegate?.deleteNum()
        }
    }
    func resetTypeBtn() {
        for i in 21...23 {
            let btn: UIButton = viewWithTag(i) as! UIButton
            btn.backgroundColor = UIColor.gray
        }
    }

    lazy var typeView: UIView = {
        let view = UIView()

        return view
    }()

    lazy var numberView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var calculatorView: UIView = {
        let view = Bundle.main.loadNibNamed("CalculatorView", owner: self, options: nil)?.last as! UIView
        return view
    }()

    func createTypeButton(tag: Int, title: String) -> UIButton {
        let btn = UIButton()
        btn.adjustsImageWhenHighlighted = false
        btn.backgroundColor = UIColor.gray
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.titleLabel?.numberOfLines = 0
        btn.tag = tag
        btn.setTitle(title, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(KSMoneyKeyBoard.clickTypeBtn(_:)), for: UIControlEvents.touchUpInside)
        return btn
    }

}
