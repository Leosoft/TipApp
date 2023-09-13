//
//  TipCalculatorModel.swift
//  TipApp
//
//  Created by Leonardo Zabala on 13/09/2023.
//

import Foundation

enum RoundingOption:Int{
    case none
    case up
    case down
}

struct TipCalculatorModel{
    var billAmount: Double = 1.00
    var tipPercentage: Double = 0.10
    var numberOfPeople: Int = 1
    var roundingOption:RoundingOption = .none
    
}
