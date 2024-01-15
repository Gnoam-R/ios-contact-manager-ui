//
//  AlertPresenter.swift
//  contact-management
//
//  Created by 박찬호 on 1/15/24.
//

import UIKit

class AlertPresenter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "경고", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
    }
}
