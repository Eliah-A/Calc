//
//  Tip.swift
//  Calc
//
//  Created by Илья Сергеевич on 20.01.2023.
//

import Foundation

enum Tip {
    case none
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case castom(value: Int)
    
    var stringValue: String {
        
        switch self {
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .castom(value: let value):
            return String(value)
        }
    }
}
