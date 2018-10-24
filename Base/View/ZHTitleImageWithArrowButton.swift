//
//  ZHTitleImageWithArrowButton.swift
//  zhonline
//
//  Created by 韩旭 on 2018/9/7.
//  Copyright © 2018年 韩旭. All rights reserved.
//

import Foundation
class ZHTitleImageWithArrowButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(.moreColor, for: .normal)
        titleLabel?.font = UIFont.normal12
        setImage(UIImage(named: "homeArrow"), for: .normal)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     这个方法里调整布局
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width + 2
    }
}
