//
//  ViewController.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 6/19/22.
//

import UIKit

class ViewController: UIViewController {

    private var getBooksService = GetBooksService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getBooksService.getBooks(by: "The lord of the ring") { (result: Result<[Book], Error>) in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let books):
                print(books)
            }
        }
    }


}

