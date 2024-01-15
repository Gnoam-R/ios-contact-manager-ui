//
//  addContactView.swift
//  contact-management
//
//  Created by 박찬호 on 1/11/24.
//

import UIKit

class AddContactView: UIViewController {
    private var contactListStorage: ContactListStorage?
    private var alertPresenter: AlertPresenter!
    private var nameContact: String?
    private var phoneContact: String?
    private var ageContact: Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    required init?(coder: NSCoder) {
        self.contactListStorage = nil
        super.init(coder: coder)
    }
    
    init?(coder: NSCoder, contactListStorage: ContactListStorage) {
        self.contactListStorage = contactListStorage
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresenter = AlertPresenter(viewController: self)
        setView()
    }
    
    private func setView() {
        title = "새연락처"
        nameLabel.text = "이름"
        ageLabel.text = "나이"
        phoneLabel.text = "연락처"
    }
    
    private func unWrappedSender(name: String?, phone: String?, age: Int?) throws -> ContactList {
        guard let name,
              let phone,
              let age
        else { throw ContactListError.ContactListWrongInput }
        return ContactList(name: name, phoneNumber: phone, age: age)
    }
    
    private func createContactFromInput() -> ContactList? {
        guard let name = nameContact, isValidName(name),
              let phone = phoneContact, isValidPhoneNumber(phone),
              let age = ageContact, validateAge(age) else {
            alertPresenter.showAlert("유효하지 않은 입력입니다.")
            return nil
        }
        return ContactList(name: name, phoneNumber: phone, age: age)
}
    
    private func addContact(_ contact: ContactList) {
        do {
            self.contactListStorage?.addContact(contact)
            dismiss(animated: true)
        } catch {
            alertPresenter.showAlert("연락처를 추가하는데 문제가 생겼습니다.")
        }
    }
}

extension AddContactView {
    @IBAction func didWriteName(_ name: UITextField) {
        nameContact = name.text
    }
    
    @IBAction func didWriteAge(_ age: UITextField) {
        if let ageText = ageTextField.text, let age = Int(ageText) {
            ageContact = age
        } else {
            ageContact = nil
        }
    }
    @IBAction func didWritePhone(_ phone: UITextField) {
        phoneContact = phone.text
    }
    
    @IBAction func didTappedCancel(_ sender: Any){
        dismiss(animated: true)
    }
    
    @IBAction func didTappedSave(_ sender: Any) {
        if let contact = createContactFromInput() {
            addContact(contact)
        }
    }
}
