//
//  KSTallyAddController.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/24.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit

class KSTallyAddController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "记一笔"
        view.backgroundColor = UIColor.white
        view.addSubview(moneyText)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.done, target: self, action: #selector(KSTallyAddController.clickSave))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clickSave() {
        let price: Float = Float(moneyText.priceText.text!)!

        print("点击保存")
    }

    func setAddType(_ type: TallyType) {
        moneyText.setType(type)
    }

    lazy var moneyText: KSMoneyText = {
        let text: KSMoneyText = KSMoneyText(frame: CGRect(x: 0, y: AppNavHeight+10, width: Int(AppWidth), height: 80))

        return text
    }()
}
