//
//  SplitCalculator.swift
//  TipApp
//
//  Created by Leonardo Zabala on 15/09/2023.
//

import Foundation
class SplitCalculator {
    static func calculatePerPersonShare(totalAmount: Double, numberOfPeople: Int) -> Double {
        guard numberOfPeople > 0 else {
            return 0.0
        }
        
        return totalAmount / Double(numberOfPeople)
    }
}

