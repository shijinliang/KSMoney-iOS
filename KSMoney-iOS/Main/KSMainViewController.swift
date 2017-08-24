//
//  KSMainViewController.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/24.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit
import MJRefresh

class KSMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var page: Int = 1
    var curDay: Int = 0
    var selectDay: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "小史记账"
        automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.

        view.addSubview(tableView)
        view.addSubview(addView)
        addView.block = { () in
            let addCtrl = KSTallyAddController()
            addCtrl.setAddType(.expend)
            self.navigationController?.pushViewController(addCtrl, animated: true)
        }
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: 🐔 private
    func getData() {
        let params: [String:Any] = ["pagenum":page]
        KSNetTool.getTallys(params, success: { (models) in
            if models.count==0 && self.page>1 {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
                return
            }
            self.dealwithData(models)
            self.endRefresh()
        }) { (error) in
            if self.page>1 {
                self.page = self.page-1
            }
            self.endRefresh()
        }
    }
    func endRefresh() {
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
    }

    func dealwithData(_ models: [KSTallyModel]) -> Void {
        if page == 1 {
            self.groupArray.removeAll()
            self.dataDic.removeAll()
        }
        var dic = self.dataDic
        for model in models {
            let month = model.month
            var array: [KSTallyModel]
            if let dayArr = dic[month] {
                array = dayArr
            } else {
                array = [KSTallyModel]()
            }
            array.append(model)
            array.sort(by: { (model1, model2) -> Bool in
                return model1.create_at > model2.create_at
            })
            dic.updateValue(array, forKey: month)
        }
        self.dataDic = dic

        let allMonth: [String] = dic.keys.sorted { (month1, month2) -> Bool in
            return month1>month2
        }
        self.groupArray = allMonth

        tableView.reloadData()

    }
    //MARK: 🐶Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupArray.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupArray[section]
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let str = groupArray[section]
        let array = dataDic[str]
        return (array?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KSTallyCell.cellWithTableView(tableView) as! KSTallyCell
        //let cell = KSTallyCell.cell(tableView: tableView)
        if indexPath.section < groupArray.count {
            let str = groupArray[indexPath.section]
            let array: [KSTallyModel] = dataDic[str]!
            if indexPath.row < array.count {
                let model = array[indexPath.row]
                cell.model = model
                if (selectDay == "") || (selectDay != model.day) {
                    selectDay = model.day
                    cell.dayLabel.text = selectDay
                    cell.weekLabel.text = model.week
                } else {
                    cell.dayLabel.text = ""
                    cell.weekLabel.text = ""
                }
            }
        }
        return cell
    }


    lazy var tableView: UITableView = {
        let tableview: UITableView = UITableView(frame: CGRect(x: 0, y: AppNavHeight, width: Int(AppWidth), height: Int(AppHeight)-Int(AppNavHeight)-AppBottomHeight), style: UITableViewStyle.grouped)
        tableview.backgroundColor = UIColor.white
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 60
        //tableview.separatorStyle = UITableViewCellSeparatorStyle.none
        tableview.separatorColor = UIColor(hex: "f5f5f5")
        tableview.mj_header = MJRefreshStateHeader(refreshingBlock: { 
            self.page = 1
            self.getData()
        })
        tableview.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.page = self.page+1
            self.getData()
        })
        return tableview
    }()

    lazy var groupArray: [String] = {
        let array: [String] = []
        return array
    }()
    lazy var dataDic: [String: [KSTallyModel]] = {
        let dic: [String: [KSTallyModel]] = [:]
        return dic
    }()

    //后期改为右下角的一个圆圈加好
    lazy var addView : KSMainTallyAddView = {
        let view = KSMainTallyAddView(frame: CGRect(x: Int(AppWidth-82), y: Int(AppHeight)-AppBottomHeight-82, width: 82, height:82))
        //KSMainTallyAddView(frame: CGRect(x: 0, y: Int(AppHeight)-AppBottomHeight-AppBottomHeight, width: Int(AppWidth), height: AppBottomHeight))
        return view
    }()
    

}
