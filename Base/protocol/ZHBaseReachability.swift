//
//  ZHBaseReachability.swift
//  zhonline
//
//  Created by 韩旭 on 2018/9/7.
//  Copyright © 2018年 韩旭. All rights reserved.
//

import Foundation
import Alamofire

class ZHBaseReachability:NSObject{
    static let instance: ZHBaseReachability = ZHBaseReachability()
    var unreachableDownloadingClosure:(()->())?
    var reachabilityWatchPlayerClosure:((_ status:NetworkReachabilityManager.NetworkReachabilityStatus)->())?
    class func shared() -> ZHBaseReachability {
        return instance
    }
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "www.baidu.com")
    }()
}
extension ZHBaseReachability{
    func judgeDownloadOrNot(_ view:UIView,_ result:@escaping ()->()){
        guard reachability?.isReachable == true else{
            view.makeToast("网络链接不可用")
            return
        }
        if true == reachability?.isReachableOnEthernetOrWiFi {
            result()
            return
        }
        let buyView = ZHBuyPopView()
        buyView.btnBuy.setTitle("继续下载", for: .normal)
        buyView.lblTitle.text = "您当前在2G/3G/4G网络下，是否继续下载？"
        buyView.clickBuyClosure = {
            () in
            result()
        }
        buyView.showInView(view)
    }
    func startListening(){
        reachability?.listener = {
            status in
            if let closure = self.reachabilityWatchPlayerClosure {
                closure(status)
            }
            switch status {
            case .reachable(.ethernetOrWiFi):
                print("this is wifi \(status)")
            case .reachable(.wwan):
                print("this is not wifi \(status)")
            case .notReachable:
                print("this is not reachable \(status)")
                guard let closure = self.unreachableDownloadingClosure else{
                    return
                }
                closure()
            case .unknown:
                print("this is unknown \(status)")
            }
        }
        reachability?.startListening()
    }
}
