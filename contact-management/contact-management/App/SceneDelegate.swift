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
        contactListStorage.addContact(ContactList(name: "노움", phoneNumber: "010-1111-1111", age: 20))
        contactListStorage.addContact(ContactList(name: "샘", phoneNumber: "010-2222-2222", age: 21))
        contactListStorage.addContact(ContactList(name: "폴", phoneNumber: "010-3333-3333", age: 22))
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

