//
//  UIApplication.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 26.10.2020.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
