//
//  KSMainViewController.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/24.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit

class KSMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "小史记账"
        // Do any additional setup after loading the view.

        view.addSubview(addView)
        addView.block = { () in
            let addCtrl = KSTallyAddController()
            self.navigationController?.pushViewController(addCtrl, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var addView : KSMainTallyAddView = {
        let view = KSMainTallyAddView(frame: CGRect(x: 0, y: Int(AppHeight)-AppBottomHeight, width: Int(AppWidth), height: AppBottomHeight))
        return view
    }()
    

}
