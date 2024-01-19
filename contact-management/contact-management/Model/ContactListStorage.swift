//
//  ContactListStorage.swift
//  contact-management
//
//  Created by Roh on 1/3/24.
//

import Foundation

final class ContactListStorage {
    private var contactList: [ContactList]
    
    init(contactList: [ContactList]) {
        self.contactList = contactList
    }
    
    func getContact(_ pos: Int) -> ContactList {
        self.contactList[pos]
    }
    
    func addContact(_ contacts: ContactList) {
        self.contactList.append(contacts)
    }
    
    func deleteContact(_ pos: Int) {
        self.contactList.remove(at: pos)
    }
    
    func changeContact(_ pos: Int, _ contacts: ContactList) {
        self.contactList[pos] = contacts
    }
    
    func countContactList() -> Int {
        return self.contactList.count
    }
    
    func filterContacts(by senderText: String) -> [ContactList] {
        return contactList.filter { contact in
            contact.name.lowercased().contains(senderText)
        }
    }
}
