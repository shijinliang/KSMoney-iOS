//
//  KSTallyCell.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/26.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit

class KSTallyCell: UITableViewCell {

    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var model: KSTallyModel? {
        didSet {
            if let name = model?.category?.parent_name {
                categoryLabel.text = "\(name) · \(model?.category?.name ?? "")"
            } else {
                categoryLabel.text = model?.category?.name
            }
            moneyLabel.text = (model?.price)!.formatPrice()
            if (model?.in_account_id)! > 0 && (model?.out_account_id)! > 0 {
                moneyLabel.textColor = UIColor(hex: "00B5FF")
                self.typeIcon.image = UIImage(named: "icon_transfer")
            } else if (model?.in_account_id)! > 0 {
                moneyLabel.textColor = UIColor(hex: "FF6710")
                self.typeIcon.image = UIImage(named: "icon_income")
            } else {
                moneyLabel.textColor = UIColor(hex: "999999")
                self.typeIcon.image = UIImage(named: "icon_expend")
            }
            remarkLabel.text = (model?.remark)!
        }
    }

}
