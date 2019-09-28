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
        addSwiptExitOneLevel()
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
        expression = ""
        cacheCount = 0
        cacheArray = []
        expLabel.text = ""
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
            if calculateExpression(exp: expression) == 24 {
            //if calculateExpression(exp: "(9-7/7)*3") == 24 {
            //if calculateExpression(exp: "(9+3)*(3-1)") == 24 {
                expLabel.text = "Bingo!"
            }
        }
    }
    
    func calculateExpression(exp: String) -> Float {
        print("calculate exp ", exp)
        if exp.contains("(") {
            var newExp = String(exp)
            var start:String.Index
            var startNext:String.Index
            while true {
                if newExp.contains("(") == false {
                    break
                }
                start = newExp.index(of: "(")!
                startNext = newExp.index(after: start)
                
                var end = newExp.startIndex
                
                var braceCount:Int = 0
                for element in newExp {
                    print(element)
                    if element == "(" {
                        braceCount = braceCount + 1
                    } else if element == ")" {
                        braceCount = braceCount - 1
                        if braceCount == 0 {
                            break
                        }
                    }
                    end = newExp.index(after: end)
                }
                let endNext = newExp.index(after: end)
                
                let braceExp = String(newExp[start..<endNext])
                let pureExp = String(newExp[startNext..<end])
                print("braceExp ", braceExp)
                print("pureExp", pureExp)
                let part = calculateExpression(exp: pureExp)
                newExp = newExp.replacingOccurrences(of: braceExp, with: String(part))
                print("after replace ", newExp)
            }
            return calculatePureExp(pureExp:newExp)
        }
        
        return calculatePureExp(pureExp: exp)
    }
    
    func calculatePureExp(pureExp: String) -> Float {
        var allNumber:[Float] = [Float]()
        var allOpt:[Character] = [Character]()
        var numberCount:Int = 0
        var optCount:Int = 0
        var curEle:String = ""
        let allOptString:String = "+-*/"
        let highOptString:String = "/*"
        for char in pureExp {
            if allOptString.contains(char) {
                let thisNumber = Float(curEle)
                allNumber.append(thisNumber!)
                numberCount = numberCount + 1
                allOpt.append(char)
                optCount = optCount + 1
                curEle = ""
            } else {
                curEle = curEle + String(char)
            }
        }
        let thisNumber = Float(curEle)
        allNumber.append(thisNumber!)
        
        var calculated:Float = 0
        //calculate /*
        for n in 0...optCount - 1 {
            if highOptString.contains(allOpt[n]) {
                let num1 = allNumber[n]
                let num2 = allNumber[n + 1]
                switch(allOpt[n]) {
                case "*":
                    calculated = num1 * num2
                    break;
                case "/":
                    calculated = num1 / num2
                    break;
                default:
                    return 0
                }
                allNumber[n] = -1
                allNumber[n + 1] = calculated
                allOpt[n] = "!"
            }
        }
        for n in 0...optCount - 1 {
            if allOpt[n] != "!" {
                let num1 = allNumber[n]
                var num2 = allNumber[n + 1]
                if num2 == -1 {
                    for j in n+1...allNumber.count - 1 {
                        if allNumber[j] != -1 {
                            num2 = allNumber[j]
                            break
                        }
                    }
                }
                switch(allOpt[n]) {
                    case "+":
                    calculated = num1 + num2
                    break;
                    case "-":
                    calculated = num1 - num2
                    break;
                    default:
                    return 0
                }
                allNumber[n] = -1
                allNumber[n + 1] = calculated
                allOpt[n] = "!"
            }
        }
        return calculated
    }
}
