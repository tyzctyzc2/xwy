//
//  GameCalculator.swift
//  GetBlue
//
//  Created by tyzc on 2019/9/28.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import Foundation

class GameCalculator {
    static func calculateExpression(exp: String) -> Float {
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
    
    static func calculatePureExp(pureExp: String) -> Float {
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
