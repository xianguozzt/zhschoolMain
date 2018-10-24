//
//  ZHRootViewController.swift
//  zhonline
//
//  Created by 韩旭 on 2018/8/20.
//  Copyright © 2018年 韩旭. All rights reserved.
//
import Alamofire
import Foundation
class ZHRootViewController: ZHBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let imgName = getLaunchImage() else {
            return
        }
        let img:UIImageView = UIImageView(image: UIImage(named: imgName))
        view.addSubview(img)
        img.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        ZHBaseReachability.shared().startListening()
        getPubdata()
        ZHDownloadingModel.shared.replaceLocalData()
        
    }
    
}
extension ZHRootViewController{
    func getPubdata() {
        let rootVC = UIApplication.shared.delegate as? AppDelegate
        if let result = rootVC?.window?.rootViewController?.isKind(of: ZHTabBarController.self) {
            if result {
                self.removeFromParentViewController()
                return
            }
        }
        ZHPubData.shared().pubconfig()
        ZHPubData.shared().pubConfigClosure = {
            (_) in
            
            //if data != nil{
                rootVC?.window?.rootViewController = ZHTabBarController()
            //}else{
            //    self?.view.makeToast("没有网络啦，建议检查网络设置是否开启")
            //}
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            [weak self] () in
            self?.getPubdata()
        })
    }
    func getLaunchImage()->String?{
        let viewSize = UIScreen.main.bounds.size
        let viewOrientation = "Portrait"
        
        
        //遍历资源库中的所有启动图片，找出符合条件的
        if let imagesDict = Bundle.main.infoDictionary  {
            if let imagesArray = imagesDict["UILaunchImages"] as? [[String: String]] {
                for dict in imagesArray {
                    if let sizeString = dict["UILaunchImageSize"],
                        let imageOrientation = dict["UILaunchImageOrientation"] {
                        let imageSize = CGSizeFromString(sizeString)
                        if __CGSizeEqualToSize(imageSize, viewSize)
                            && viewOrientation == imageOrientation {
                            if let imageName = dict["UILaunchImageName"] {
                                return imageName
                            }
                        }
                    }
                }
            }
        }
        
        return nil
    }
}
