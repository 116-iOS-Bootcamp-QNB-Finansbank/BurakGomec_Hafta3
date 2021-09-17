//
//  CalculatorViewController.swift
//  BasicUIComponents
//
//  Created by Semih Emre ÜNLÜ on 11.09.2021.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    private var isTyping: Bool = false, operatorControl = false, multipleOperationControl = false
    private var bufferFirstNumberString = "", bufferSecondNumberString = ""
    private var selectedOperator = MathOperations.KeyboardInputs.none
    private var firstNumber = 0.0, secondNumber = 0.0, result = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
 
    @IBAction func digitButtonTapped(_ sender: UIButton) {
        guard let number = sender.currentTitle else {return }
        guard let displayText = resultLabel.text else{return }
        let digit = String(number)
        
        if operatorControl { // if selected operator is not nil
            if isTyping {
                resultLabel.text = displayText + digit
            } else {
                resultLabel.text = digit
                isTyping.toggle()
            }
            bufferSecondNumberString += digit
        }
        else {
                if isTyping {
                    print(displayText)
                    resultLabel.text = displayText + digit
                } else {
                    print(digit)
                    resultLabel.text = digit
                    isTyping.toggle()
                }
        }
        bufferFirstNumberString += digit
    }
    
    
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        guard let operation = sender.currentTitle else {return }
        
        switch operation {
        
        case "√":
            selectedOperator = .squareRoot
            getSelectedOperationName()
            
        case "+":
            selectedOperator = .addition
            operatorControl = true
            
        case "-":
            selectedOperator = .subtraction
            operatorControl = true
            
        case "X":
            selectedOperator = .multiplication
            operatorControl = true
            
        case "/":
            selectedOperator = .division
            operatorControl = true
            
        case "C":
            clearResultLabel()
            
        case "=":
            if selectedOperator != .none{
                getSelectedOperationName()
            }
            
        default:
            break
        }
        
        if operatorControl{
            if multipleOperationControl {
                firstNumber = result
            }
            else {
                firstNumber = Double(bufferFirstNumberString)!
            }
           
            bufferFirstNumberString = ""
            isTyping = false
        }


        UIView.animate(withDuration: 0.15) { sender.backgroundColor = .red
        } completion: { _ in
            sender.backgroundColor = .lightGray
        }


  
    }
    
}

//MARK: - Case Operations
extension CalculatorViewController {
    
    private func clearResultLabel(){
        resultLabel.text = "0"; bufferFirstNumberString = ""; bufferSecondNumberString = ""
        selectedOperator = .none
        isTyping = false; operatorControl = false; multipleOperationControl = false
        firstNumber = 0.0; secondNumber = 0.0; result = 0.0
    }
    
    private func getSelectedOperationName(){
        var operationResult: Double?
        
        if Double(bufferSecondNumberString) != nil || selectedOperator == .squareRoot{
        switch selectedOperator {
        case .addition:
            secondNumber = Double(bufferSecondNumberString)!
            operationResult = MathOperations.shared.addition(firstNumber: firstNumber, secondNumber: secondNumber)
            
        case .squareRoot:
            let value = NSString(string: resultLabel.text ?? "0").doubleValue
            operationResult = MathOperations.shared.squareRoot(_number: value)
            
        case .subtraction:
            secondNumber = Double(bufferSecondNumberString)!
            operationResult = MathOperations.shared.subtraction(firstNumber: firstNumber, secondNumber: secondNumber)

        case .multiplication:
            secondNumber = Double(bufferSecondNumberString)!
            operationResult = MathOperations.shared.multiplication(firstNumber: firstNumber, secondNumber: secondNumber)
            
        case .division:
            secondNumber = Double(bufferSecondNumberString)!
            operationResult = MathOperations.shared.division(firstNumber: firstNumber, secondNumber: secondNumber)
            
        case .none:
            break
        }

        guard operationResult != nil else {return }
        resultLabel.text = String(operationResult!)
        result = operationResult!
        multipleOperationControl = true
        bufferSecondNumberString = ""
        isTyping = false
        operatorControl = false
        }
    }
}
