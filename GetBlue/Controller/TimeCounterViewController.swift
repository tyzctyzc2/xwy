//
//  TimeCounterViewController.swift
//  GetBlue
//
//  Created by tyzc on 2019/9/21.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class TimeCounterViewController : MyBaseViewController {
    func setTotalMinutes(s: Int) {
        totalMinutes = s
        totalSeconds = s * 60
    }
    let synthesizer = AVSpeechSynthesizer()
    let audioSession = AVAudioSession.sharedInstance()
    
    @IBOutlet weak var CounterLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var settingLabel: UILabel!
    var inCounterMode:Bool = false
    var counterTimer:Timer!
    var refreshTimer:Timer!
    var secondLeft:Int!
    var totalMinutes:Int! = 1
    var totalSeconds:Int! = 60
    var speechSecond:[Int] = [Int]()
    @IBAction func StartStopTouchDown(_ sender: Any) {
        if inCounterMode == true {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiptExitOneLevel()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        settingLabel.text = String(totalMinutes) + " Minutes"
        UIScreen.main.brightness = CGFloat(0.2)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("counter view will disappear")
        stopTimer()
        UIScreen.main.brightness = CGFloat(0.3)
    }
    
    func startTimer() {
        inCounterMode = true
        startButton.setTitle("Stop", for: .normal)
        CounterLabel.text = "Go!!!"
        readText(text: "请开始")
        iniSpeechSecond()
        secondLeft = totalSeconds
        counterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
        /*DispatchQueue.global(qos: .default).async(execute: {
            self.refreshTimer = Timer(timeInterval: 1, target: self, selector: #selector(self.doTimeRefresh), userInfo: nil, repeats: true)
            RunLoop.main.add(self.refreshTimer!, forMode: RunLoop.Mode.common)
        })*/
    }
    
    @objc
    func doTimeRefresh() {
        NSLog("doTimeRefresh called")
    }
    
    func iniSpeechSecond() {
        speechSecond.append(30)
        speechSecond.append(10)
        speechSecond.append(9)
        speechSecond.append(8)
        speechSecond.append(7)
        speechSecond.append(6)
        speechSecond.append(5)
        speechSecond.append(4)
        speechSecond.append(3)
        speechSecond.append(2)
        speechSecond.append(1)
    }
    
    func stopTimer() {
        if inCounterMode == false {
            return
        }
        inCounterMode = false
        counterTimer.invalidate()
        startButton.setTitle("Start", for: .normal)
    }
    
    func readText(text: String) {
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        }catch let error as NSError {
            print(error.code)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh_CN")
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.1
        utterance.volume = 10
        
        synthesizer.speak(utterance)
    }
    
    @objc
    func runTimedCode() {
        secondLeft = secondLeft - 1
        NSLog("time changed..." + String(secondLeft))
        if secondLeft == 0 {
            CounterLabel.text = "End"
            readText(text: "请停止")
            stopTimer()
            return
        }
        CounterLabel.text = String(secondLeft)
        if speechSecond.count > 0 {
            if secondLeft == speechSecond[0] {
                var text = String(secondLeft)
                if secondLeft > 20 {
                    text = "还有 " + text
                }
                readText(text: text)
                speechSecond.removeFirst()
            } else {
                AudioServicesPlaySystemSound(1152)
            }
        }
    }
}
