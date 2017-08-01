//
//  KSMainTallyAddView.swift
//  KSMoney-iOS
//
//  Created by xiaoshi on 2017/7/24.
//  Copyright © 2017年 kamy. All rights reserved.
//

import UIKit
import SnapKit

typealias AddBlock = () -> Void

class KSMainTallyAddView: UIView {

    var block : AddBlock?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 1, alpha: 0.3)
        addSubview(recordBtn)
        recordBtn.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }

        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func clickAddBlock() {
        block!()
    }

    lazy var recordBtn: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor(white: 1, alpha: 0.3)
        button.adjustsImageWhenHighlighted = false
        button.setTitle("  记一笔", for: UIControlState.normal)
        button.setTitleColor(ColorMain, for: UIControlState.normal)
        button.setImage(UIImage(named: "icon_tally_add"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(KSMainTallyAddView.clickAddBlock), for: UIControlEvents.touchUpInside)
        return button
    }()

}
