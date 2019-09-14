//
//  Game24ViewController.swift
//  GetBlue
//
//  Created by tyzc on 2019/8/11.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import UIKit

class Game24ViewController : MyBaseViewController
{
    @IBOutlet weak var buttonNumber1: UIButton!
    @IBOutlet weak var buttonNumber2: UIButton!
    @IBOutlet weak var buttonNumber3: UIButton!
    @IBOutlet weak var buttonNumber4: UIButton!
    @IBOutlet weak var buttonRefresh: UIButton!
    
    var number1:Int!
    var number2:Int!
    var number3:Int!
    var number4:Int!
    
    var number1Used:Bool = false
    var number2Used:Bool = false
    var number3Used:Bool = false
    var number4Used:Bool = false
    
    var braceCount:Int = 0
    var expression:String = ""
    var cacheCount:Int = 0
    var cacheArray:[Int] = []
    
    @IBOutlet weak var expLabel: UILabel!
    
    @IBOutlet weak var optAdd: UIButton!
    @IBOutlet weak var optSub: UIButton!
    @IBOutlet weak var optMul: UIButton!
    @IBOutlet weak var optDiv: UIButton!
    
    @IBOutlet weak var optLeftBrace: UIButton!
    @IBOutlet weak var optRightBrace: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beautyMyButton(button: buttonNumber1)
        self.beautyMyButton(button: buttonNumber2)
        self.beautyMyButton(button: buttonNumber3)
        self.beautyMyButton(button: buttonNumber4)
        self.beautyMyButton(button: buttonRefresh)
        
        self.beautyMyButton(button: optAdd)
        self.beautyMyButton(button: optSub)
        self.beautyMyButton(button: optMul)
        self.beautyMyButton(button: optDiv)
        
        self.beautyMyButton(button: optLeftBrace)
        self.beautyMyButton(button: optRightBrace)
        
        cacheArray.reserveCapacity(10)
        resetGame()
    }
    
    func resetGame() {
        number1 = Int.random(in: 1 ... 9)
        buttonNumber1.setTitle(String(number1), for: .normal)
        buttonNumber1.isEnabled = true
        number2 = Int.random(in: 1 ... 9)
        buttonNumber2.setTitle(String(number2), for: .normal)
        buttonNumber2.isEnabled = true
        number3 = Int.random(in: 1 ... 9)
        buttonNumber3.setTitle(String(number3), for: .normal)
        buttonNumber3.isEnabled = true
        number4 = Int.random(in: 1 ... 9)
        buttonNumber4.setTitle(String(number4), for: .normal)
        buttonNumber4.isEnabled = true
        
        number1Used = false
        number2Used = false
        number3Used = false
        number4Used = false
        
        braceCount = 0
    }
    
    @IBAction func refreshButtonTouchDown(_ sender: Any) {
        resetGame()
    }
    
    @IBAction func optButtonTouchDown(_ sender: Any) {
        let touchedButton:UIButton = sender as! UIButton
        switch touchedButton {
        case buttonNumber1:
            number1Used = true
            buttonNumber1.isEnabled = false
            break
        case buttonNumber2:
            number2Used = true
            buttonNumber2.isEnabled = false
            break
        case buttonNumber3:
            number3Used = true
            buttonNumber3.isEnabled = false
            break
        case buttonNumber4:
            number4Used = true
            buttonNumber4.isEnabled = false
            break
        case optLeftBrace:
            braceCount = braceCount + 1
            break
        case optRightBrace:
            braceCount = braceCount - 1
        default:
            break
        }
        expression = expression + touchedButton.title(for: .normal)!
        
        expLabel.text = expression
        
        if number1Used && number2Used && number3Used && number4Used && braceCount == 0 {
            if calculateExpression(exp: expression) == true {
                expLabel.text = "Bingo!"
            }
        }
    }
    
    func calculateExpression(exp: String) -> Bool {
        if exp.contains("(") {
            let start = exp.index(of: "(")
            let end = exp.lastIndex(of: ")")
            let braceExp = exp[start!..<end!]
        }
        return true
    }
    
    func calculateBraceExp(braceExp: String) -> Float {
        return 0
    }
}
