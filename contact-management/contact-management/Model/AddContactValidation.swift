//
//  AddContactValidation.swift
//  contact-management
//
//  Created by 박찬호 on 1/15/24.
//

import Foundation

extension AddContactView {
    private func isMatchingPattern(_ string: String, pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: string.utf16.count)
            return regex.firstMatch(in: string, options: [], range: range) != nil
        } catch {
            print("올바르지 않은 입력입니다 \(error.localizedDescription)")
            return false
        }
    }

    // 이름
    func isValidName(_ name: String) -> Bool {
        return !name.isEmpty
    }

    // 전화번호
    func isValidPhoneNumber(_ number: String) -> Bool {
        let phoneNumberPattern = "^(02|0\\d{2,3})-\\d{3,4}-\\d{4}$"
        return isMatchingPattern(number, pattern: phoneNumberPattern)
    }

    // 나이 유효성 검사
    func validateAge(_ age: Int) -> Bool {
        let minimumAge = 1
        let maximumAge = 200
        return age >= minimumAge && age <= maximumAge
    }
}
