//
//  ZHBaseViewController.swift
//  zhonline
//
//  Created by hanxu on 2018/7/17.
//  Copyright © 2018年 hanxu. All rights reserved.
//
import UIKit
import SnapKit
import Then
import Reusable
import Kingfisher
import ReactiveCocoa
import ReactiveSwift
import Result
import MBProgressHUD
class ZHBaseViewController: UIViewController{
    
    //var viewModel:ZHBaseViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
            
            
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        configUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear \(self)")
        configNavigationBar()
        UITableView.appearance().estimatedRowHeight = 0;
        UITableView.appearance().estimatedSectionHeaderHeight = 0;
        UITableView.appearance().estimatedSectionFooterHeight = 0;
       
    }
    deinit{
        print("\(self) dealloc")
    }
    func configUI() {
        
    }
    func bindViewModel() {}
    func configNavigationBar() {
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.barStyle(.white)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                //navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_black"), style: .plain, target: self, action: #selector(pressBack))
                let btn = Button(type:.custom)
                btn.frame = CGRect(x:0,y: 0,width: 45,height: 40)
                btn.setImage(UIImage(named: "nav_back_black"), for: .normal)
                btn.addTarget(self, action: #selector(pressBack), for: .touchUpInside)
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView:btn)
            }
            //DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            //    MBProgressHUD.hide(for: self.view, animated: true)
            //})
            
            
        }
        navi.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black,NSAttributedStringKey.font:UIFont.normal17]
    }
    
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }
    func getNaviHeight()->CGFloat? {
        return navigationController?.navigationBar.frame.size.height
    }
    func getTabbarHeight()->CGFloat?{
        return self.tabBarController?.tabBar.frame.size.height
    }
    
}

extension ZHBaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
}


