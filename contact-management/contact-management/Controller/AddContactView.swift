//
//  addContactView.swift
//  contact-management
//
//  Created by 박찬호 on 1/11/24.
//

import UIKit

final class AddContactView: UIViewController {
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
    
    private var phoneFormat: PhoneFormat?
    
    required init?(coder: NSCoder) {
        self.contactListStorage = nil
        phoneFormat = nil
        super.init(coder: coder)
    }
    
    init?(coder: NSCoder, contactListStorage: ContactListStorage) {
        self.contactListStorage = contactListStorage
        phoneFormat = PhoneFormat.init(appenCharacter: "-")
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
        
        nameTextField.addTarget(self, action: #selector(nameFieldDidChange(_:)), for: .editingChanged)
        ageTextField.addTarget(self, action: #selector(ageFieldDidChange(_:)), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(phoneFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func unWrappedSender(name: String?, phone: String?, age: Int?) throws -> ContactList {
        guard let name,
              let phone,
              let age
        else {
            throw ContactListError.ContactListWrongInput
        }
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
    @IBAction func didTappedCancel(_ sender: Any){
        let cancel: AlertActionHandler = { [weak self] _ in
            self?.dismiss(animated: true)
        }
        present(Alert.stopEditContact(cancel).alertController, animated: true)
    }
    
    @IBAction func didTappedSave(_ sender: Any) {
        let _ : AlertActionHandler = { [weak self] _ in
            self?.dismiss(animated: true)
        }
        do {
            let unWrappedResult = try unWrappedSender(
                name: nameContact,
                phone: phoneContact,
                age: ageContact
            )
            
            let isNameValid = try ContactValidateCheck.name(unWrappedResult.name).check
            let isAgeValid = try ContactValidateCheck.age(unWrappedResult.age).check
            let isPhoneValid = try ContactValidateCheck.phone(unWrappedResult.phoneNumber).check
            
            if isNameValid,
               isAgeValid,
               isPhoneValid
            {
                self.contactListStorage?.addContact(unWrappedResult)
                NotificationCenter.default.post(name: NSNotification.Name("ModalDismissNC"), object: nil, userInfo: nil)
                self.dismiss(animated: true)
            }
        } 
        catch ContactListError.ContactNameIsValid {
            present(Alert.isCorrectName.alertController, animated: true)
        } 
        catch ContactListError.ContactAgeIsValid {
            present(Alert.isCorrectAge.alertController, animated: true)
        } 
        catch ContactListError.ContactPhoneIsValid {
            present(Alert.isCorrectPhone.alertController, animated: true)
        } 
        catch ContactListError.ContactListWrongInput {
            present(Alert.isCorrectList.alertController, animated: true)
        } 
        catch {
            return
        }
    }
}

extension AddContactView {
    @objc func nameFieldDidChange(_ nameField: UITextField) {
        nameContact = nameField.text
    }
    
    @objc func ageFieldDidChange(_ ageField: UITextField) {
        guard let age = ageField.text else {
            return
        }
        ageContact = Int(age)
    }
    
    @objc func phoneFieldDidChange(_ phoneField: UITextField) {
        guard let phone = phoneField.text else { return }
        phoneField.text = phoneFormat?.addCharacter(at: phone)
        phoneContact = phoneField.text
    }
}
