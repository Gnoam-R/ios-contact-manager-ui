//
//  Alert.swift
//  contact-management
//
//  Created by Roh on 1/14/24.
//

import UIKit

typealias AlertActionHandler = ((UIAlertAction) -> Void)

enum Alert {
    case stopEditContact(AlertActionHandler)
    case isCorrectList
    case isCorrectName
    case isCorrectAge
    case isCorrectPhone
    
    var title: String {
        switch self {
        case .stopEditContact:
            return "정말로 취소하시겠습니까?"
        case .isCorrectList:
            return "유효한 입력값이 아닙니다."
        case .isCorrectName:
            return "입력된 이름 정보가 잘못되었습니다"
        case .isCorrectAge:
            return "입력된 나이 정보가 잘못되었습니다"
        case .isCorrectPhone:
            return "입력된 연락처 정보가 잘못되었습니다"
        }
    }
    
    var body: String {
        ""
    }
    
    var alertController: UIAlertController {
        let alertController = UIAlertController(
            title: self.title,
            message: self.body,
            preferredStyle: .alert
        )
        
        switch self {
        case .stopEditContact(let action):
            alertController.addAction(UIAlertAction(
                title: "예",
                style: .default,
                handler: action
            ))
            alertController.addAction(UIAlertAction(title: "아니요", style: .cancel))
            return alertController
       
        case .isCorrectList:
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            return alertController
            
        case .isCorrectName:
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            return alertController
            
        case .isCorrectAge:
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            return alertController
            
        case .isCorrectPhone:
            let okAction = UIAlertAction(title: "확인", style: .default)
            alertController.addAction(okAction)
            return alertController
        }
    }
}
