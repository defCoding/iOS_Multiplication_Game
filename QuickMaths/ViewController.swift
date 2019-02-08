//
//  ViewController.swift
//  QuickMaths
//
//  Created by Kevin Cao on 11/7/18.
//  Copyright © 2018 Define Coding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var theModel: QuickMathsModel = QuickMathsModel()
    
    var hasDecimal = false // Used to prevent double decimal points.

    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var correctLabel: UILabel!
    @IBOutlet var incorrectLabel: UILabel!
    
    @IBAction func aDigitIsPressed(_ sender: UIButton) {
        let btnTitle: String = sender.title(for: .normal)!
        
        if (btnTitle == ".") {
            if (!self.hasDecimal) {
                self.answerLabel.text = self.answerLabel.text! + btnTitle
                self.hasDecimal = true
            }
        } else {
            self.answerLabel.text = self.answerLabel.text! + btnTitle
        }
    }
    
    @IBAction func anOperationIsPressed(_ sender: UIButton) {
        let btnTitle: String = sender.title(for: .normal)!
        
        switch (btnTitle) {
        case "AC":
            self.answerLabel.text = ""
            self.hasDecimal = false
        case "+/-":
            if (self.answerLabel.text!.prefix(1) == "-") {
                let index = self.answerLabel.text!.index(self.answerLabel.text!.startIndex, offsetBy: 1)..<self.answerLabel.text!.endIndex
                
                self.answerLabel.text = String(self.answerLabel.text![index])
            } else {
                self.answerLabel.text = "-" + self.answerLabel.text!
            }
        case "Enter":
            let usrAnswer: Int = theModel.strToNumber(str: self.answerLabel.text!)
            
            let isCorrect: Bool = theModel.compareAnswers(given: usrAnswer)
            
            if (isCorrect) {
                self.answerLabel.backgroundColor = UIColor.green
            } else {
                self.answerLabel.backgroundColor = UIColor.red
            }
            
            Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(revertLabelColor), userInfo: nil, repeats: false)
            
            self.answerLabel.text = ""
            self.updateLabels()
        default:
            break
        }
    }
    
    func updateLabels() {
        self.questionLabel.text = self.theModel.getNumAsStr(num: 1) + " * " + self.theModel.getNumAsStr(num: 2) + " ?"
        
        self.correctLabel.text = "\(self.theModel.amtRight)"
        self.incorrectLabel.text = "\(self.theModel.amtWrong)"
    }
    
    @objc func revertLabelColor() {
        self.answerLabel.backgroundColor = self.questionLabel.backgroundColor
    }
}

