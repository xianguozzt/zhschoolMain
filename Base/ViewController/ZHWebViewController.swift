//
//  ZHWebViewController.swift
//  zhonline
//
//  Created by hanxu on 2018/7/17.
//  Copyright © 2018年 hanxu. All rights reserved.
//
import UIKit
import WebKit
import Foundation
class ZHWebViewController: ZHBaseViewController {
    
    var request: URLRequest!
    var requestHtml:String?
    lazy var webView: WKWebView = {
        let ww = WKWebView()
        ww.allowsBackForwardNavigationGestures = true
        ww.navigationDelegate = self
        ww.uiDelegate = self;
        return ww
    }()
    
    lazy var progressView: UIProgressView = {
        let pw = UIProgressView()
        pw.trackImage = UIImage.init(named: "nav_bg")
        pw.progressTintColor = UIColor.white
        return pw
    }()
    
    convenience init(url: String?) {
        self.init()
        guard let myurl = URL(string: url ?? "") else{
            self.requestHtml = url
            return
        }
        self.request = URLRequest(url: myurl)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        if let html = requestHtml{
            webView.loadHTMLString(html, baseURL: nil)
        }else {
            webView.load(request)
        }
    }
    
    override func configUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints{ $0.edges.equalTo(self.view.usnp.edges) }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_reload"),
                                                            target: self,
                                                            action: #selector(reload))
    }
    
    @objc func reload() {
        webView.reload()
    }
    
    override func pressBack() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension ZHWebViewController: WKNavigationDelegate, WKUIDelegate {
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress >= 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        progressView.setProgress(0.0, animated: false)
        navigationItem.title = title ?? (webView.title ?? webView.url?.host)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else{return}
        if url.absoluteString.hasPrefix("tel:"){
            UIApplication.shared.openURL(url)
        }
        decisionHandler(.allow)
    }
}
extension ZHWebViewController:Routable{
    static func initWithParams(params: RouterParameter?) -> UIViewController {
        guard let url = params?["url"] as? String else {
            return UIViewController()
        }
        
        let myUrl = ZHWebViewController.combineUrl(url)
        return ZHWebViewController(url: myUrl)
    }
}
extension ZHWebViewController{
    static func combineUrl(_ myurl:String)->String{
        var url = myurl
        //guard let userData = UserData.getUserData() else{return url}
        let Url = URL(string: url)
        let query = Url?.query
        let userId = UserData.getUserData()?.userId ?? ""
        if let query = query  {
            if query.contains("userId") {
                
            }else{
                url.append("&userId="+userId)
            }
            
        }else{
            url.append("?userId="+userId)
        }
        let nickName = UserData.getUserData()?.nickname ?? ""
            url.append("&uname="+nickName)
        
        
        let base = URL(string: baseUrl)
        if let host = base?.host{
            url.append("&domain="+host)
            let arr = host.components(separatedBy: ".")
            if arr.count > 1 {
                if arr[0].hasPrefix("sta"){
                  url.append("&env="+arr[0])
                }else{
                    url.append("&env=Production")
                }
            }
        }
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            url.append("&version=v"+version)
        }
        let date = compileTime.getCompileDate()
        let time = compileTime.getCompileTime()
        if let date = date,let time = time {
            url.append("&compiletime="+date+"-"+time)
        }

        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
