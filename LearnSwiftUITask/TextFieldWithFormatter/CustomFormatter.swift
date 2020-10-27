//
//  CustomFormatter.swift
//  LearnSwiftUITask
//
//  Created by Pavel Murzinov on 24.10.2020.
//

import Foundation

final class PhoneNumberFormatter: Formatter {
    
    override func string(for obj: Any?) -> String? {
        guard let string = obj as? String else {
            return nil
        }
        return addSpaceBetweenEverySymbol(string)
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = addSpaceBetweenEverySymbol(string) as AnyObject
        return true
    }
    
}

extension PhoneNumberFormatter {
    func addSpaceBetweenEverySymbol(_ string: String) -> String {
        return string.phoneFromat()
    }
}

extension String {
    func makeNumberString() -> String {
        return self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }
    
    func removeAllSpace() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    func formatPhone(with mask: String) -> String {
        let numbers = self.removeAllSpace().makeNumberString()
        var result = ""
        var index = numbers.startIndex
        for ch in mask.enumerated() where index < numbers.endIndex {
            if ch.element == "X" {
                if !result.contains("+7") && numbers.first != "7" {
                    result.append("7")
                }
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch.element)
            }
        }
        return result
    }
    
    func phoneFromat() -> String {
        self.formatPhone(with: "X (XXX) XXX XX-XX")
    }
}
