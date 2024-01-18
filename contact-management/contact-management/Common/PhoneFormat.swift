//
//  PhoneFormat.swift
//  contact-management
//
//  Created by Roh on 1/15/24.
//

import UIKit

public class PhoneFormat {
    public var appendCharacter: Character = "-"
    private var digits: String = ""
    
    public init(appenCharacter: Character) {
        appendCharacter = appenCharacter
    }
    
    public func addCharacter(at text:String) -> String {
        digits = text
        removeCharacter()
        guard digits.count >= 2 else { return digits }
        
        if firstIsZero() {
            if secondIsTwo() {
                if getDigitsCountIn(3, 5) {
                    appendCharacter(2)
                } else if getDigitsCountIn(6, 9) {
                    appendCharacter(2)
                    appendCharacter(6)
                } else if getDigitsCountIn(10, 10) {
                    appendCharacter(2)
                    appendCharacter(7)
                }
            } else {
                if getDigitsCountIn(4, 6) {
                    appendCharacter(3)
                } else if getDigitsCountIn(7, 10) {
                    appendCharacter(3)
                    appendCharacter(7)
                } else if getDigitsCountIn(11, 11) {
                    appendCharacter(3)
                    appendCharacter(8)
                }
            }
        } else if firstIsOne() {
            if secondIsZeroThreeIn() {
                if getDigitsCountIn(4, 6) {
                    appendCharacter(3)
                } else if getDigitsCountIn(7, 10) {
                    appendCharacter(3)
                    appendCharacter(7)
                } else if getDigitsCountIn(11, 11) {
                    appendCharacter(3)
                    appendCharacter(8)
                }
            } else {
                if getDigitsCountIn(5, 8) {
                    appendCharacter(4)
                }
            }
        }
        return digits
    }
}

extension PhoneFormat {
    private func firstIsZero() -> Bool {
        if digits.first == "0" { return true }
        return false
    }
    
    private func secondIsTwo() -> Bool {
        if digits.count >= 2 && digits[1] == "2" { return true }
        return false
    }
    
    private func firstIsOne() -> Bool {
        if digits.first == "1" { return true }
        return false
    }
    
    private func secondIsZeroThreeIn() -> Bool {
        if digits.count >= 2 {
            if digits[1] == "0" || digits[1] == "1" || digits[1] == "2" || digits[1] == "3" { return true }
        }
        return false
    }
    
    private func getDigitsCountIn(_ start: Int, _ end: Int) -> Bool {
        return digits.count >= start && digits.count <= end
    }
    
    private func appendCharacter(_ index: Int) {
        digits.insert(appendCharacter, at: digits.getStringIndex(i: index))
    }
    
    private func removeCharacter() {
        digits = digits.replacingOccurrences(of: "\(appendCharacter)", with: "")
    }
}

extension String {
    func getStringIndex(i: Int) -> String.Index {
        return self.index(self.startIndex, offsetBy: i)
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

