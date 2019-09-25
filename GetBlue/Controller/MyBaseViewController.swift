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
    
    func addSwiptExitOneLevel() {
        let right = UISwipeGestureRecognizer(target : self, action : #selector(swiptToExitOneLevelRight))
        right.direction = .right
        self.view.addGestureRecognizer(right)
        
        let left = UISwipeGestureRecognizer(target : self, action : #selector(swiptToExitOneLevelLeft))
        left.direction = .left
        self.view.addGestureRecognizer(left)
        
        let down = UISwipeGestureRecognizer(target : self, action : #selector(swiptToExitOneLevelDown))
        down.direction = .down
        self.view.addGestureRecognizer(down)
    }
    
    @objc
    func swiptToExitOneLevelLeft(){
        NSLog("do swipe....")
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc
    func swiptToExitOneLevelRight(){
        NSLog("do swipe....")
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc
    func swiptToExitOneLevelDown(){
        NSLog("do swipe....")
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
