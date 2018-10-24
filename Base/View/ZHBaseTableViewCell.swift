//
//  ZHBaseTableViewCell.swift
//  zhonline
//
//  Created by hanxu on 2018/7/17.
//  Copyright © 2018年 hanxu. All rights reserved.
//
import UIKit
import Reusable

class ZHBaseTableViewCell: UITableViewCell, Reusable {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}

}
