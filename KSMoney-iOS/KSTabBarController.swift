//
//  KSTabBarController.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/31.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit

class KSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addCtrl(KSMainViewController(), "流水", "tabbar_list")
        addCtrl(UIViewController(), "账户", "tabbar_account")
        addCtrl(UIViewController(), "分类", "tabbar_category")
        addCtrl(UIViewController(), "我的", "tabbar_me")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addCtrl(_ ctrl: UIViewController, _ title: String, _ imageName: String) -> Void {
        let item = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: imageName+"_s"))
        //item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        item.setTitleTextAttributes([NSForegroundColorAttributeName:ColorGray, NSFontAttributeName:UIFont.systemFont(ofSize: 10)], for: UIControlState.normal)
        item.setTitleTextAttributes([NSForegroundColorAttributeName:ColorMain, NSFontAttributeName:UIFont.systemFont(ofSize: 10)], for: UIControlState.selected)
        
        ctrl.tabBarItem = item;
        let nav = UINavigationController(rootViewController: ctrl)
        self.addChildViewController(nav)
    }

    //setImage(_ image: UIImage?, for state: UIControlState)
}
