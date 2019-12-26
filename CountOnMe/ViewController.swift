//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    @IBOutlet weak var ACbutton: UIButton!
    let checking = Checking()
    let calculator = Calculator()
    
    //MARK : - Test Button à enlever
    @IBOutlet weak var testButton: UIButton!
    @IBAction func testButtonAction(_ sender: UIButton) {
        
    }
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: .result, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(errorAlert), name: .error, object: nil)
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal)
            else {return}
        calculator.addNumber(number: numberText)
    }
    
    @IBAction func tappedACButton(_ sender: Any) {
        calculator.reset()
    }
    
    
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        guard let symbol = sender.title(for: .normal)
            else {return}
        calculator.addOperator(operationSymbol: symbol)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.calculate()
    }
    
    // updating the text view
     @objc func updateTextView() {
       if calculator.elementTextView.isEmpty {
          textView.text = "0"
       } else {
          textView.text = calculator.elementTextView
       }
    }
     @objc func errorAlert(_ notification: Notification) {
       var alertMessage = ""
         if let error = notification.userInfo?["Error"] as? DefaultSituation {
           switch error {
           case .isIncorrect:
             alertMessage = " Expression is incorrect "
           case .haveNotEnoughElement:
             alertMessage = " Missing element to generate calcul "
           case .haveResult:
             alertMessage = " Result is already showed on screen "
           case .divisionByZero:
             alertMessage = " Sorry, you can't make a division by 0 "
           case .operatorIsAlredySet:
             alertMessage = " Sorry, you've already made your choice "
            case .unknowOperator:
            alertMessage = " Sorry, this symbol do not exist "
           }
         }
        //Showing message to the user with UIAlertController
         let alertVC = UIAlertController(title: "ERROR", message: alertMessage, preferredStyle: .alert)
         alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
         self.present(alertVC, animated: true, completion: nil)
     }
}


