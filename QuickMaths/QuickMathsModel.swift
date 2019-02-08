//
//  QuickMathsModel.swift
//  QuickMaths
//
//  Created by Kevin Cao on 11/7/18.
//  Copyright © 2018 Define Coding. All rights reserved.
//

import Foundation

class QuickMathsModel: NSObject {
    var firstNumber: Int
    var secondNumber: Int
    var answer: Int
    var guesses: Int
    var amtWrong: Int
    var amtRight: Int
    
    override init() {
        self.firstNumber = 0 // Initialized value won't be used.
        self.secondNumber = 0 // Initialized value won't be used.
        self.answer = 0 // Initialized value won't be used.
        self.guesses = 0
        self.amtWrong = 0
        self.amtRight = 0
        super.init()
        self.generateNumbers()
    }
    
    func generateNumbers() {
        self.firstNumber = Int(arc4random_uniform(UInt32(41))) - 20
        self.secondNumber = Int(arc4random_uniform(UInt32(41))) - 20
        self.answer = firstNumber * secondNumber
    }
    
    func compareAnswers(given: Int) -> Bool {
        let isCorrect: Bool = self.answer == given
        if (isCorrect) {
            self.guesses = 0
            self.amtRight += 1
            self.generateNumbers()
        } else {
            if (self.guesses >= 1) {
                self.amtWrong += 1
                self.guesses = 0
                self.generateNumbers()
            } else {
                self.guesses += 1
            }
        }
        
        return isCorrect
    }
    
    func strToNumber(str: String) -> Int {
        return Int(str)!
    }
    
    func getNumAsStr(num: Int) -> String {
        let chosenNum: Int
        if (num == 1) {
            chosenNum = self.firstNumber
        } else {
            chosenNum = self.secondNumber
        }
        
        return chosenNum < 0 ? "(\(chosenNum))" : "\(chosenNum)"
    }
}
