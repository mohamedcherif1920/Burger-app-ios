//
//  MoneyFormatter.swift
//  Big Burger
//
//  Created by mac on 19/09/2021.
//

import Foundation
class MoneyFormatter: NumberFormatter {
    
    override init() {
        super.init()
        numberStyle = .decimal
        decimalSeparator = "."
        groupingSize = 2
        minimumIntegerDigits = 2
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func string(from number: Int, currency: Bool = false) -> String {
        var currencyText = ""
        if currency {
            currencyText = "€"
        }
        if (number == 0) {
            return ""
        }
        
        return "\(string(from: NSNumber(value:number)) ?? "" ) \(currencyText)"
    }
}
