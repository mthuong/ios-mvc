//
//  ViewController.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 6/19/22.
//

import UIKit

class ViewController: UIViewController {

    private var getBooksService = GetBooksService()
    
    private var books: [Book] = []
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.self.description())
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getBooksService.getBooks(by: "The lord of the ring") { [weak self] (result: Result<[Book], Error>) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.alert("Error", message: error.localizedDescription)
                }
                
            case .success(let books):
                self?.books = books
                DispatchQueue.main.async {
                    // Reload tableview
                    self?.tableView.reloadData()
                }
            }
        }
        
        setupUI();
    }
    
    private func setupUI() -> Void {
        view.addSubview(tableView)
        
        setupContraints()
    }
    
    private func setupContraints() -> Void {
        NSLayoutConstraint.activate([
            tableView.topAnchor
                .constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor
                .constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor
                .constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.self.description()) as? BookCell {
            cell.displayBook(books[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
}

