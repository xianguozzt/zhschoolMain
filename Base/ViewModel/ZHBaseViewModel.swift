//
//  ZHBaseViewModel.swift
//  zhonline
//
//  Created by 韩旭 on 2018/7/17.
//  Copyright © 2018年 韩旭. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result
import HandyJSON
typealias ZHBaseScrollViewHeadDataClosure = (_ indexPath: IndexPath)->ZHBaseCollectionReusableView
class ZHBaseViewModel:NSObject{
    let (netSignal,netObserver) = Signal<NSString,NoError>.pipe()
    var baseHeadScrollViewHeadClosure:ZHBaseScrollViewHeadDataClosure?
    let action:Action<Any, Any, NoError> = {
        Action<Any, Any, NoError>{ (input) -> SignalProducer<Any, NoError> in
            print("input: ", input)
            //ApiLoadingProvider.request(input as! ZHNetApi, model: SubscribeListModel.self) { (returnData) in
                
            //}
            return SignalProducer<Any, NoError>({(innerObserver, _) in
                //发起网络请求
                innerObserver.send(value: 1)
                innerObserver.sendCompleted()
            })
        }
    }()
    func updateData<T: HandyJSON>(api:ZHNetApi,comData data:T.Type){
        ApiLoadingProvider.request( api, model: data) {
            [weak self] (returnData) in
            guard returnData != nil else{
                self?.netObserver.send(value: "0")
                return 
            }
            guard let data = returnData else{
                self?.netObserver.send(value: "0")
                return
            }
            self?.manageData(data)
            self?.netObserver.send(value: "1")
        }
    }
    override init() {
        super.init()
        initBind()
    }
    func manageData<T: HandyJSON>(_ myData:T){
        
    }
    deinit {
        print("viewModel deinit \(self)")
    }
    func loadData(){
        
    }
    func initBind() {
        
    }
}
#if false
extension ZHBaseViewModel {
    
        func toViewController() -> ZHBaseViewController {
        
            let viewModelClassName = String(describing: type(of: self))
        
            let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        
            let controllerClassName = clsName + "." + viewModelClassName.replacingOccurrences(of: "Model", with: "Controller")
        
            if let cls = NSClassFromString(controllerClassName) as? ZHBaseViewController.Type {
            
                    return cls.init(viewModel: self)
            
            } else {
            
                    assert(false, "无法转换controller")
            
            }
        
        }
    
}
#endif

