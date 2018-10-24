//
//  ZHBaseRoutProtocol.swift
//  zhonline
//
//  Created by 韩旭 on 2018/8/21.
//  Copyright © 2018年 韩旭. All rights reserved.
//

import Foundation
import UIKit

public protocol RouterPathable {
    var any: AnyClass { get }
    var params: RouterParameter? { get }
}

public typealias  RouterParameter = [String: Any]
protocol Routable {
    static func initWithParams(params: RouterParameter?) -> UIViewController
}


open class Router{
    
    open class func openTel(_ phone:String) {
        if let url = URL(string: "tel://\(phone)") {
            UIApplication.shared.openURL(url)
        }
    }
    
    open class func open(_ path:RouterPathable , present: Bool = false , animated: Bool = true , presentComplete: (()->Void)? = nil){
        if let cls = path.any as? Routable.Type {
            let vc = cls.initWithParams(params: path.params)
            vc.hidesBottomBarWhenPushed = true
            let topViewController = topVC
            topViewController?.view.endEditing(true)
            if topViewController?.navigationController != nil && !present {
                topViewController?.navigationController?.pushViewController(vc, animated: animated)
            }else{
                topViewController?.present(vc, animated: animated , completion: presentComplete)
            }
        }
    }
}
