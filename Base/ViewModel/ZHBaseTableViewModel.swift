//
//  ZHBaseTableViewModel.swift
//  zhonline
//
//  Created by 韩旭 on 2018/7/24.
//  Copyright © 2018年 韩旭. All rights reserved.
//

import Foundation
import UIKit

typealias ZHCellRenderBlock = (_ indexPath:NSIndexPath,_ tablleView:UITableView) -> UITableViewCell
typealias ZHCellSelectBlock = (_ indexPath:NSIndexPath,_ tablleView:UITableView) -> Void

class ZHBaseTableViewModel: ZHBaseViewModel,UITableViewDelegate,UITableViewDataSource {

    
    var cellRender:ZHCellRenderBlock! // 创建cell的block
    var cellSlect:ZHCellSelectBlock? // 选中cell的block
    var cellHeight:CGFloat = UITableViewAutomaticDimension
    //var estimatedHeight:CGFloat = 50// 预估高度
    var sectionCount:Int = 0// 区数
    var rawCount:Int = 0// 行数
    
    /** 区数 */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionCount
    }
    /** 行数 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rawCount
    }
    /** 行高 */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    /** cell */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellRender(indexPath as NSIndexPath,tableView)
        return cell
    }

    /** 点击事件 */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectBlock = cellSlect else{
            print("cell的选中block没有实例")
            return
        }
        selectBlock(indexPath as NSIndexPath,tableView)
    }
}

