//
//  MathOperations.swift
//  BasicUIComponents
//
//  Created by Burak on 17.09.2021.
//

import Foundation

class MathOperations{
    static let shared = MathOperations()
    
    enum Operations {
        case squareRoot
        case addition
        case subtraction
        case multiplication
        case division
    }
    
    enum KeyboardInputs : String{
        case squareRoot = "√"
        case addition = "+"
        case subtraction = "-"
        case multiplication = "X"
        case division = "/"
        case none = ""
    }

    
    func squareRoot(_number: Double)->Double{
        return sqrt(_number)
    }
    
    func addition(firstNumber: Double, secondNumber: Double)->Double{
        return firstNumber + secondNumber
    }
    
    func subtraction(firstNumber: Double, secondNumber: Double)->Double{
        return firstNumber - secondNumber
    }

    func multiplication(firstNumber: Double, secondNumber: Double)->Double{
        return firstNumber * secondNumber
    }
    
    func division(firstNumber: Double, secondNumber: Double)->Double{
        return firstNumber / secondNumber
    }

    private init(){ }
}



