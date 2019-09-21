//
//  TimerPickerViewController.swift
//  GetBlue
//
//  Created by tyzc on 2019/9/21.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import UIKit

class TimerPickerViewController : UIViewController {
    
    @IBOutlet weak var OneMinute3010Button: UIButton!
    @IBOutlet weak var OneMinute3015Button: UIButton!
    @IBOutlet weak var TwoMinute3015Button: UIButton!
    
    @IBAction func TypeTimerTouchDown(_ sender: Any) {
        self.performSegue(withIdentifier: "starttimer", sender: self)
    }
    
}
