//
//  TimeCounterViewController.swift
//  GetBlue
//
//  Created by tyzc on 2019/9/21.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import UIKit

class TimeCounterViewController : MyBaseViewController {
    @IBOutlet weak var CounterLabel: UILabel!
    var inCounterMode:Bool = false
    @IBAction func StartStopTouchDown(_ sender: Any) {
        if inCounterMode == true {
            stopTimer()
        }
    }
    
    func startTimer() {
        
    }
    
    func stopTimer() {
        
    }
}
