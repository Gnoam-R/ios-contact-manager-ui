//
//  SceneDelegate.swift
//  contact-management
//
//  Created by Roh on 1/2/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private func addDummyData(Storage contactListStorage: ContactListStorage) {
        contactListStorage.addContact(ContactList(name: "Noah", phoneNumber: "010-1111-1111", age: 20))
        contactListStorage.addContact(ContactList(name: "Sam", phoneNumber: "010-2222-2222", age: 21))
        contactListStorage.addContact(ContactList(name: "Paul", phoneNumber: "010-3333-3333", age: 22))
        contactListStorage.addContact(ContactList(name: "Olivia", phoneNumber: "010-4444-4444", age: 23))
        contactListStorage.addContact(ContactList(name: "Emma", phoneNumber: "010-5555-5555", age: 24))
        contactListStorage.addContact(ContactList(name: "Liam", phoneNumber: "010-6666-6666", age: 25))
        contactListStorage.addContact(ContactList(name: "Mia", phoneNumber: "010-7777-7777", age: 26))
        contactListStorage.addContact(ContactList(name: "Ethan", phoneNumber: "010-8888-8888", age: 27))
        contactListStorage.addContact(ContactList(name: "Ava", phoneNumber: "010-9999-9999", age: 28))
        contactListStorage.addContact(ContactList(name: "William", phoneNumber: "010-1010-1010", age: 29))
    }

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let contactList: [ContactList] = [ContactList]()
        let contactListStorage = ContactListStorage(contactList: contactList)
        addDummyData(Storage: contactListStorage)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyBoard.instantiateViewController(identifier: "ContactListView") { coder in
            return ContactListView.init(coder: coder, contactListStorage: contactListStorage)
        }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: firstViewController)
        window.makeKeyAndVisible()
        self.window = window
    }
}

