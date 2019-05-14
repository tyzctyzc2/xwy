//
//  MyBaseViewController.swift
//  GetBlue
//
//  Created by tyzc on 2019/4/18.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import UIKit
import AVFoundation

class MyBaseViewController : UIViewController
{
    public func beautyMyButton(button: UIButton)
    {
        button.layer.cornerRadius=20;
        button.clipsToBounds=true;
        button.layer.backgroundColor = self.view.tintColor.cgColor;

        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.setTitleColor(UIColor.gray, for: .disabled)

    }
}
