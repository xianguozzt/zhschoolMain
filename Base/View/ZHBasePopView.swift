//
//  ZHBasePopView.swift
//  zhonline
//
//  Created by 韩旭 on 2018/9/18.
//  Copyright © 2018年 韩旭. All rights reserved.
//

import Foundation
class ZHBasePopView:ZHBaseView{
    func showInView(_ superView:UIView){
        superView.window?.addSubview(self)
        self.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.7)
        self.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}
