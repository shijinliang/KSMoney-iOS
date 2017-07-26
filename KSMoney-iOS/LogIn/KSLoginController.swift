//
//  KSLoginController.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/24.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class KSLoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(phoneText)
        view.addSubview(passwordText)
        view.addSubview(enterBtn)

        phoneText.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(20)
            make.height.equalTo(50)
            make.top.equalTo(view.snp.top).offset(40)
        }

        passwordText.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(20)
            make.height.equalTo(50)
            make.top.equalTo(phoneText.snp.bottom).offset(20)
        }

        enterBtn.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordText.snp.bottom).offset(30)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clickEnter() -> Void {
        let params : [String : Any] = ["phone":phoneText.text!, "password":passwordText.text!]
        KSNetTool.loginWithParams(params, success: { (model) in
            print("登录成功" + model.token)
            self.loginSuccess()
        }) { (error) in
            print("失败")
        }
    }

    func loginSuccess() {
        let window : UIWindow = (UIApplication.shared.delegate?.window!!)!
        DispatchQueue.main.async {
            if !window.isKeyWindow {
                window.makeKeyAndVisible()
            }

            window.rootViewController = UINavigationController(rootViewController: KSMainViewController())
        }
    }

    lazy var phoneText: UITextField = {
        let text = UITextField()
        text.placeholder = "请输入手机号"
        return text
    }()

    lazy var passwordText: UITextField = {
        let text = UITextField()
        text.placeholder = "请输入密码"
        return text
    }()

    lazy var enterBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setTitle("进入应用", for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.backgroundColor = ColorMain
        btn.addTarget(self, action: #selector(KSLoginController.clickEnter), for: UIControlEvents.touchUpInside)
        return btn
    }()

}
