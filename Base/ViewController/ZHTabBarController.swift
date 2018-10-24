//
//  ZHTabBarController.swift
//  zhonline
//
//  Created by hanxu on 2018/7/17.
//  Copyright © 2018年 hanxu. All rights reserved.
//
import UIKit

class ZHTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        
        /// 首页
        //let onePageVC = UHomeViewController(titles: ["推荐",
         //                                            "VIP",
         //                                            "订阅",
         //                                            "排行"],
        //                                    vcs: [UBoutiqueListViewController(),
        //                                          UVIPListViewController(),
        //                                          USubscibeListViewController(),
        //                                          URankListViewController()],
        //                                    pageStyle: .navgationBarSegment)
        let onePageVC = ZHHomeViewController()
        
        addChildViewController(onePageVC,
                               title: "首页",
                               image: UIImage(named: "tab_home"),
                               selectedImage: UIImage(named: "tab_home_S"))
        var titles = [String]()
        var vcs = [ZHOpenClassViewController]()
        if let found = ZHPubData.shared().getpubFoundModel()?.tabs {
            for item in found{
                if let label = item.key {
                    
                    switch label{
                    case "open":
                        vcs.append(ZHOpenClassViewController())
                    case "wangshou":
                        vcs.append(ZHWangshouClassViewController())
                    case "mianshou":
                        vcs.append(ZHMainShouViewController())
                    default:
                        continue
                    }
                    titles.append(item.label ?? "")
                }
            }
        }else{
            titles = ["公开课",
                      "网授课",
                      "面授课"]
            vcs = [ZHOpenClassViewController(),
                   ZHWangshouClassViewController(),
                   ZHMainShouViewController()]
        }

        let classVC = ZHFoundViewController(titles: titles,
                                                vcs: vcs,
                                                pageStyle: .topTabBar)
        addChildViewController(classVC,
                               title: "发现",
                               image: UIImage(named: "tab_class"),
                               selectedImage: UIImage(named: "tab_class_S"))
        
        
        /// 书架
        let bookVC = ZHLearnViewController(titles: ["我的课程","学习历史","我的下载"],
                                           vcs: [ZHMyLessonViewController(),
                                                  ZHMyLessonHistoryViewController(),
                                                  ZHMyDownloadViewController()],
                                           pageStyle: .topTabBar)
        addChildViewController(bookVC,
                               title: "学习",
                               image: UIImage(named: "tab_book"),
                               selectedImage: UIImage(named: "tab_book_S"))
        
        
        /// 我的
        let mineVC = ZHMineViewController()
        addChildViewController(mineVC,
                               title: "我的",
                               image: UIImage(named: "tab_mine"),
                               selectedImage: UIImage(named: "tab_mine_S"))
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        //childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        //if UIDevice.current.userInterfaceIdiom == .phone {
        //    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        //}
        
        let attributes =  [NSAttributedStringKey.foregroundColor: UIColor.titleColor,
                           NSAttributedStringKey.font: UIFont.normal12]
        childController.tabBarItem.setTitleTextAttributes(attributes, for: .selected)
        childController.tabBarItem.setTitleTextAttributes(attributes , for: .normal)
        addChildViewController(ZHNavigationController(rootViewController: childController))
    }
    
}

extension ZHTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
