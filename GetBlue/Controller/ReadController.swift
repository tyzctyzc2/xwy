//
//  ReadController.swift
//  GetBlue
//
//  Created by tyzc on 2019/5/18.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import Foundation
import WebKit

class ReadController : MyBaseViewController, WKNavigationDelegate, UIGestureRecognizerDelegate {
    var webView: WKWebView!
    var currentPage : Int = 1
    var pageKeyName : String = "currentPage"
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        NSLog("done loading");
        
        let js = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='300%'"
        
        webView.evaluateJavaScript(js, completionHandler: nil)
        
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    func savePageSetting() {
        let defaults = UserDefaults.standard
        defaults.set(currentPage, forKey: pageKeyName)
    }
    
    func loadPageSetting() {
        let defaults = UserDefaults.standard
        currentPage = defaults.integer(forKey: pageKeyName)
        if (currentPage == 0) {
            currentPage = 1
        }
    }
    
    override func loadView() {

        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        loadPageSetting()
        
        if (loadCurrentPage() == false) {
            
        }
        
        webView.allowsBackForwardNavigationGestures = true
        webView.isUserInteractionEnabled = true
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.bounces = false
      
        let longPressRecognizer = UILongPressGestureRecognizer()
        longPressRecognizer.delegate = self
        longPressRecognizer.addTarget(self, action: #selector(gestureRecognizer))
        self.webView!.scrollView.addGestureRecognizer(longPressRecognizer)
        
        let swipeRecongizer = UISwipeGestureRecognizer()
        swipeRecongizer.direction = UISwipeGestureRecognizer.Direction.left
        swipeRecongizer.addTarget(self, action: #selector(onSwipeView))
        self.webView!.scrollView.addGestureRecognizer(swipeRecongizer)
        
        let rightSwipeRecongizer = UISwipeGestureRecognizer()
        rightSwipeRecongizer.direction = UISwipeGestureRecognizer.Direction.right
        rightSwipeRecongizer.addTarget(self, action: #selector(onSwipeView2))
        self.webView!.scrollView.addGestureRecognizer(rightSwipeRecongizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        NSLog("3333333333")
        return true
    }
    
    @objc func onSwipeView(sender: UISwipeGestureRecognizer) {
        if (sender.direction == UISwipeGestureRecognizer.Direction.left) {
            NSLog("go left ")
            goNext()
        }
        else if (sender.direction == UISwipeGestureRecognizer.Direction.right) {
            NSLog("go right ")
        }
    }
    
    @objc func onSwipeView2(sender: UISwipeGestureRecognizer) {
        if (sender.direction == UISwipeGestureRecognizer.Direction.left) {
            NSLog("go left 2")
        }
        else if (sender.direction == UISwipeGestureRecognizer.Direction.right) {
            NSLog("go right 2")
            goBack()
        }
    }
    
    func goBack() {
        if (currentPage == 1) {
            return
        }
        currentPage = currentPage - 1
        if (loadCurrentPage() == false) {
            currentPage = 1
        }
    }
    
    func goNext() {
        currentPage = currentPage + 1
        if (loadCurrentPage() == false) {
            currentPage = currentPage - 1
        }
        
    }
    
    func loadCurrentPage () -> Bool{
        let url = Bundle.main.url(forResource: String(currentPage), withExtension: "html")
        
        if (url == nil) {
            return false
        }
        
        webView.loadFileURL(url!, allowingReadAccessTo:
            Bundle.main.resourceURL!.appendingPathComponent("pvtc"))
        savePageSetting()
        return true
    }
    
    @objc func onLongPress(gestureRecognizer:UILongPressGestureRecognizer){
        NSLog("go back @@@@@@@")
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            NSLog("long press detected")
        }
    }
    
    @objc func doubleTapped(sender: UITapGestureRecognizer) {
        // do something here
        NSLog("go back ~~~~~~~~~~~~~")
    }
}
