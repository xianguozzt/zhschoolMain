//
//  ZHBaseRoute.swift
//  zhonline
//
//  Created by 韩旭 on 2018/8/21.
//  Copyright © 2018年 韩旭. All rights reserved.
//

import Foundation
enum RouterPath: RouterPathable {
    case base
    case login
    case smsCode(String)
    case purchase(foundClassListModel)
    case download(String,String)
    case detail(String,String)
    case modifyInfo
    case opinion
    case web(String)
    case changeNickName(String)
    case opinionDetail
    case entryPlayer(lessionDetailModel,playerPageDataModel,String)
    case tradeSuccess(String,tradeResultModel)
    case orderList
    case orderDetail(orderItemModel)
    case downloadDetail(String)
    case selectBu
    var any: AnyClass {
        switch self {
        case .base:
            return ZHBaseViewController.self
        case .login:
            return ZHLoginViewController.self
        case .purchase:
            return ZHPurchaseViewController.self
        case .smsCode:
            return ZHSmsCodeViewController.self
        case .download:
            return ZHDownloadListViewController.self
        case .detail:
            return ZHDetailClassViewController.self
        case .modifyInfo:
            return ZHModifyMyInfoViewController.self
        case .opinion:
            return ZHOpinionListViewController.self
        case .web:
            return ZHWebViewController.self
        case .changeNickName:
            return ZHModifyMyNickNameViewController.self
        case .opinionDetail:
            return ZHOpinionViewController.self
        case .entryPlayer:
            return ZHPlayViewController.self
        case .tradeSuccess:
            return ZHPurchaseSuccessViewController.self
        case .orderList:
            //return ZHOrderTotalViewController.self
            return ZHMyOrderListViewController.self
        case .orderDetail:
            return ZHMyOrderDetailViewController.self
        case .downloadDetail:
            return ZHDownloadDetailViewController.self
        case .selectBu:
            return ZHSelectBuViewController.self
        }
    }
    
    var params: RouterParameter? {
        switch self {
        case .purchase(let data):
            return ["model":data]
        case .smsCode(let phoneNum):
            return ["phoneNum":phoneNum]
        case .detail(let id, let type):
            return ["id":id,"type":type]
        case .web(let url):
            return ["url":url]
        case .changeNickName(let nickName):
            return ["nickName":nickName]
        case .entryPlayer(let detail,let playModel,let lessonId):
            return ["detail":detail,"playModel":playModel,"lessonId":lessonId]
        case .tradeSuccess(let poster, let model):
            return ["poster":poster,"model":model]
        case .download(let courseId, let courseType):
            return ["courseId":courseId,"courseType":courseType]
        case .orderDetail(let orderModel):
            return ["orderModel":orderModel]
        case .downloadDetail(let courseId):
            return ["courseId":courseId]
            #if false
        case .orderList:
            guard let bus = ZHPubData.shared().getBus() else {return nil}
            var model = [faxiantabModel]()
            var i = 0
            for item in bus{
                guard let label = item.label,let key = item.key else{continue}
                var bu = faxiantabModel()
                bu.label = label + "订单"
                bu.key = key + "/"
                model.append(bu)
                i += 1
            }
            
            return ["faxiantabModel":model]
            #endif
        default:
            return nil
        }
    }
}
extension Router{
    static func pushJump(userInfo:[AnyHashable : Any]){
        guard let openBy = userInfo["openBy"] as? String,let linkUrl = userInfo["linkUrl"] as? String,let schemaUrl = userInfo["schemaUrl"] as? String else{
            return
        }
        var model:topSlidersModel = topSlidersModel()
        model.openBy = openBy
        model.schemaUrl = schemaUrl
        model.linkUrl =  linkUrl
        self.schemeJump(model: model)
    }
    static func schemeJump(model:topSlidersModel){
        
        switch model.openBy {
        case "app":
            guard let scheme = model.schemaUrl?.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed) else{return}
            guard let url = URL(string: scheme) else{return}
        
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }else{
                guard let linkUrl = model.linkUrl else{return}
                Router.open(RouterPath.web(linkUrl))
            }
        case "webview":
            guard let linkUrl = model.linkUrl else{return}
            Router.open(RouterPath.web(linkUrl))
        case "browser":
            guard let linkUrl = model.linkUrl else{return}
            guard let url = URL(string: linkUrl) else {return}
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        case "internal":
            guard let scheme = model.schemaUrl else{return}
            let Url = URL(string: scheme)
            guard let par = Url?.query else{return}
            var parmeters:Dictionary<String,Any> = Dictionary()
            let arr = par.components(separatedBy: "&")
            for str in arr{
                let pair = str.components(separatedBy: "=")
                
                if pair.count == 1{
                    parmeters[pair[0]] = ""
                }else{
                    parmeters[pair[0]] = pair[1]
                }
                
            }
            guard let courseId = parmeters["id"] as? String,let type = parmeters["entityType"] as? String ,let view = parmeters["view"] as? String else{
                return
            }
            switch view {
            case "entityDetail":
                Router.open(RouterPath.detail(courseId, type))
            default:
                break
            }
            
        default:
            break
        }
        
    }
}
