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
    private let calculator = Calculator()
    
    //MARK : - Test Button à enlever
    @IBOutlet weak var testButton: UIButton!
    @IBAction func testButtonAction(_ sender: UIButton) {
        
    }
    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: .result, object: nil)
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
        if let error = calculator.isExpressionIncorrect() {
            showAlert(error: error)
        } else {
            calculator.calculate()
        }
    }
    
    // updating the text view
     @objc func updateTextView() {
       if calculator.elementTextView.isEmpty {
          textView.text = ""
       } else {
          textView.text = calculator.elementTextView
       }
    }
    
    func showAlert(error: String) {
        let alertVC = UIAlertController(title: "ERROR", message: error, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


