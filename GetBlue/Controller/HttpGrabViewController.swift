//
//  HttpGrabViewController.swift
//  GetBlue
//
//  Created by Steve Wang on 2019/3/29.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import UIKit
import AVFoundation

var pullTimer: Timer?
var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?

class HttpGrabViewController : MyBaseViewController, UIGestureRecognizerDelegate
{
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var textLabel: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
    var inPullMode = false
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    //var timer:Timer?
    var allTargetUrl:[String:String] = [:]
    
    @IBAction func actionButtonTouch(_ sender: Any) {
        switchWorkingMode()
    }
    
    func appendMessage(msg: String) {
        self.textLabel.text = self.textLabel.text + "\n"  + msg;
    }
    
    func alertMessage() {
        AudioServicesPlayAlertSound(SystemSoundID(1322))
    }
    
    func switchWorkingMode() {
        inPullMode = !inPullMode;
        
        if (inPullMode == true) {
            startButton.setTitle("Stop", for:.normal)
            //timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
            pullTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.fire), userInfo: nil, repeats: true)
        } else {
            startButton.setTitle("Start", for:.normal)
            pullTimer?.invalidate()
        }
    
    }
    
    @objc func fire()
    {
        NSLog("fire...");
        textLabel.text = "";
        grabAllHTTP();
    }
    
    func grabAllHTTP() {
        let grabCount = GrabUrlHolder.getUrlCount()
        
        self.textLabel.text = "";
        for index in 0..<grabCount {
            NSLog("start get \(index) ....")
            let cur = GrabUrlHolder.getIndexItem(index: index)
            grab1Url(name: cur.name, address: cur.url)
        }
    }
    
    func grab1Url (name: String,address: String) {
        let url = URL(string: address)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            guard let data = data else { return }
            let res = String(data: data, encoding: .utf8)!;
            if res.contains("已满") == true
            {
                NSLog("\(name) bad ...... ");
                self.appendMessage(msg: "\(name) XXX ");
            } else {
                NSLog("\(name) good !!!!! ");
                self.appendMessage(msg: "\(name) !!!!!! ");
                self.alertMessage()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GrabUrlHolder.loadUrl()
        
        //load url from setting
        //allTargetUrl["桓瑞"] = "http://sbj.speiyou.com/classes/view/ff80808166f38a05016706d2202d1db8"
        allTargetUrl["程悦"] = "http://sbj.speiyou.com/classes/view/ff80808166f38a05016706d1f81d1a11"
        allTargetUrl["姜付加"] = "http://sbj.speiyou.com/classes/view/ff8080816705ca02016706c500b6756d"
        
        super.beautyMyButton(button: startButton)
        super.beautyMyButton(button: newButton)
        super.beautyMyButton(button: backButton)
        
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier!)
        })
        
        textLabel.isEditable = false
        textLabel.isSelectable = false
        
        let doubleTap = UITapGestureRecognizer()
        doubleTap.delegate = self
        doubleTap.numberOfTouchesRequired = 2
        doubleTap.addTarget(self, action: #selector(doubleTapped))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(doubleTap)
        
        addSwiptExitOneLevel()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        NSLog("3333333333")
        return true
    }
    
    @objc func onLongPress(gestureRecognizer:UIGestureRecognizer){
        NSLog("go back @@@@@@@")
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            NSLog("long press detected")
        }
    }
    
    @objc func doubleTapped() {
        // do something here
        NSLog("go back ~~~~~~~~~~~~~")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if (inPullMode == true) {
            switchWorkingMode()
        }
        super.viewWillAppear(animated)
    }
}
