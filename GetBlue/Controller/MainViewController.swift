//
//  ViewController.swift
//  GetBlue
//
//  Created by Steve Wang on 2019/3/22.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import UIKit

class MainViewController: MyBaseViewController {
    @IBOutlet weak var xesButton: UIButton!
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var readButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        super.beautyMyButton(button: xesButton)
        super.beautyMyButton(button: gameButton)
        super.beautyMyButton(button: readButton)
        //self.mainMessageLabel.numberOfLines = 0;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
}

