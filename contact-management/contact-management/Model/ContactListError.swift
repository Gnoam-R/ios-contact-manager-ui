//
//  ContactListError.swift
//  contact-management
//
//  Created by Roh on 1/3/24.
//

enum ContactListError: Error {
    case ContactListNotFound
    case ContactListWrongInput
    case ContactNameIsValid
    case ContactAgeIsValid
    case ContactPhoneIsValid
}
