//
//  TimerPickerViewController.swift
//  GetBlue
//
//  Created by tyzc on 2019/9/21.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import UIKit

class TimerPickerViewController : MyBaseViewController {
    
    @IBOutlet weak var OneMinute3010Button: UIButton!
    @IBOutlet weak var OneMinute3015Button: UIButton!
    @IBOutlet weak var TwoMinute3015Button: UIButton!
    var pickedTotalSecond:Int! = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSwiptExitOneLevel()
    }
    
    @IBAction func TypeTimerTouchDown(_ sender: Any) {
        if let touchedButton = sender as? UIButton {
            if let buttonText = touchedButton.titleLabel?.text {
                NSLog(buttonText)
                let start = buttonText.startIndex
                let end = buttonText.firstIndex(of: " ")
                let numberString = buttonText[start..<end!]
                pickedTotalSecond = Int(numberString)!
            }
        }
        self.performSegue(withIdentifier: "starttimer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let targetController = segue.destination as? TimeCounterViewController {
            if segue.identifier == "starttimer" {
                targetController.setTotalMinutes(s: pickedTotalSecond)
            }
        }
    }
    
}
