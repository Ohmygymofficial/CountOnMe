//
//  CalculatorViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit


class CalculatorViewController: UIViewController {
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private var numberButtons: [UIButton]!
    @IBOutlet private var operatorButtons: [UIButton]!
    @IBOutlet private weak var ACbutton: UIButton!
    private let calculator = Calculator()
    
    /// View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
    }
}

private extension CalculatorViewController {
    /// View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal)
            else { return }
        calculator.addStringNumber(stringNumber: numberText)
    }
    
    @IBAction func tappedACButton(_ sender: Any) {
        calculator.reset()
    }
    
    
    @IBAction func tappedOperationButton(_ sender: UIButton) {
        guard let symbol = sender.title(for: .normal)
            else { return }
        calculator.addOperator(operationSymbol: symbol)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.checkBeforeCalculate()
    }
}

/// Display Alert when there is an error, or if not : the result of the calcul.
extension CalculatorViewController: ModelDelegate {
    func didReceiveData(_ data: String) {
        if data == "result" {
            textView.text = calculator.elementTextView
        } else {
            let alertVC = UIAlertController(title: "ERROR", message: data, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
    }
}
