//
//  File.swift
//  Calc
//
//  Created by Илья Сергеевич on 22.01.2023.
//

import Foundation

enum ScreenIdentifier {
    
    enum LogoView: String {
        case logoView
    }
    
    enum ResultView: String {
        case totalAmounPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipinputView: String {
        case tenPercentButton
        case fifteenPercentButton
        case twentyPercentButton
        case customTipButton
    }
    
    enum SplitInputView: String {
        case decrimentButton
        case incrimentButton
        case quantityValueLabel
    }
}
