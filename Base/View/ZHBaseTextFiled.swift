//
//  ZHBaseTableViewHeaderFooterView.swift
//  zhonline
//
//  Created by hanxu on 2018/7/17.
//  Copyright © 2018年 hanxu. All rights reserved.
//

import UIKit

class ZHBaseTextFiled: UITextField {

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let menuController:UIMenuController = UIMenuController.shared
        menuController.isMenuVisible = false
        return false
    }

}
