//
//  DoubleExtension.swift
//  Calc
//
//  Created by Илья Сергеевич on 21.01.2023.
//

import Foundation


extension Double {
    var currencyFormatedString: String {
        var isWholeNumer: Bool {
            isZero ? true: !isNormal ? false: self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimumFractionDigits = isWholeNumer ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}
