//
//  UIResponderExtension.swift
//  Calc
//
//  Created by Илья Сергеевич on 20.01.2023.
//

import Foundation
import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
