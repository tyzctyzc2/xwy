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
    func setTotalSeconds(s: Int) {
        totalSeconds = s
    }
    let synthesizer = AVSpeechSynthesizer()
    let audioSession = AVAudioSession.sharedInstance()
    
    @IBOutlet weak var CounterLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var inCounterMode:Bool = false
    var counterTimer:Timer!
    var secondLeft:Int!
    var totalSeconds:Int!
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
        totalSeconds = 60
        
        do {
            try audioSession.setCategory(.ambient, mode: .default, options: [])
        }catch let error as NSError {
            print(error.code)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        stopTimer()
    }
    
    func startTimer() {
        inCounterMode = true
        startButton.setTitle("Stop", for: .normal)
        CounterLabel.text = "Go!!!"
        readText(text: "请开始")
        iniSpeechSecond()
        secondLeft = totalSeconds
        counterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
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
