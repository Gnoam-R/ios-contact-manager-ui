//
//  ViewController.swift
//  contact-management
//
//  Created by Roh on 1/2/24.
//

import UIKit

final class ContactListView: UIViewController {
    private var contactListStorage: ContactListStorage?
    @IBOutlet weak var tableView: UITableView!
    var filteredArr: [ContactList] = []
    
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
        tableView.dataSource = self
        tableView.delegate = self
        
        setupSearchController()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification(_:)),
            name: NSNotification.Name("ModalDismissNC"),
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
    }
    
    @IBAction func addContact(_ sender: Any) {
        let secondViewController = storyboard?.instantiateViewController(identifier: "AddContactView") { coder in
            return AddContactView.init(coder: coder, contactListStorage: self.contactListStorage!)
        }
        secondViewController?.modalTransitionStyle = .coverVertical
        secondViewController?.modalPresentationStyle = .automatic
        let secondNavigationController = UINavigationController(rootViewController: secondViewController!)
        present(secondNavigationController, animated: true)
    }
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupSearchController() {
        // 서치바 컨트롤러의 초기화
        let searchController = UISearchController(searchResultsController: nil)
        // 서치바 내용 업데이트
        searchController.searchResultsUpdater = self
        // 네비게이션 타이틀 설정
        self.navigationItem.title = "연락처"
        // 서치바 플레이스 홀더 설정
        searchController.searchBar.placeholder = "검색"
        // 서치바 추가
        self.navigationItem.searchController = searchController
        // 서치바 항상 표시
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }
}

extension ContactListView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else {return}
        // contactListStorage 배열을 필터링하여 searchText를 포함하는 요소들만 선택
//        self.filteredArr = self.filteredArr.filter { $0.lowercased().contains(text) }
        self.tableView.reloadData()
        dump(text)
    }
}

extension ContactListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contactListStorage?.deleteContact(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }
    
    private func getContact(forID id: Int) -> ContactList? {
        guard let result = self.contactListStorage else {
            return nil
        }
        return result.getContact(id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListStorage!.countContactList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        guard let item = getContact(forID: indexPath.row) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "\(item.name) (\(item.age))"
        cell.detailTextLabel?.text = item.phoneNumber
        return cell
    }
}

extension ContactListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

