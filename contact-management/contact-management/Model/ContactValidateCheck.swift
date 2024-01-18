//
//  ContactValidateCheck.swift
//  contact-management
//
//  Created by Roh on 1/15/24.
//

import Foundation

enum ContactValidateCheck {
    case name(_ name: String)
    case age(_ age: Int)
    case phone(_ phoneNumber: String)
    
    var check: Bool {
        get throws {
            switch self {
            case .name(let name):
                if name.isEmpty { throw ContactListError.ContactNameIsValid }
                else { return true }
                
            case .age(let age):
                guard age > 0 && age <= 200 else {
                    throw ContactListError.ContactAgeIsValid
                }
                return true
                
            case .phone(let phoneNumber):
                let phoneNumberPattern = "^(02|0\\d{2,3})-\\d{3,4}-\\d{4}$"
                if isMatchingPattern(phoneNumber, pattern: phoneNumberPattern)
                {
                    return true
                }
                else { throw ContactListError.ContactPhoneIsValid }
            }
        }
    }
    
    private func isMatchingPattern(_ string: String, pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: string.utf16.count)
            return regex.firstMatch(in: string, options: [], range: range) != nil
        } catch {
            return false
        }
    }
}
