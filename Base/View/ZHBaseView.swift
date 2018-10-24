//
//  ZHBaseView.swift
//  zhonline
//
//  Created by 韩旭 on 2018/7/27.
//  Copyright © 2018年 韩旭. All rights reserved.
//

import Foundation
import UIKit
class ZHBaseView:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configUI() {
        
    }
}
