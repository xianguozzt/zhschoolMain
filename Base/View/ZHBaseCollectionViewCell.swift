//
//  ZHBaseCollectionViewCell.swift
//  zhonline
//
//  Created by hanxu on 2018/7/17.
//  Copyright © 2018年 hanxu. All rights reserved.
//
import UIKit
import Reusable

class ZHBaseCollectionViewCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}
