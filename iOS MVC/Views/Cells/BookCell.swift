//
//  BookCell.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 7/4/22.
//

import Foundation
import UIKit

class BookCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.numberOfLines = 2;
        return label
    }()
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        return label
    }()
    
    func setupUI() -> Void {
        contentView.addSubview(bookTitleLabel)
        contentView.addSubview(authorNameLabel)
        
        setupContraints()
    }
    
    func setupContraints() -> Void {
        NSLayoutConstraint.activate([
            bookTitleLabel.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 5),
            bookTitleLabel.leftAnchor
                .constraint(equalTo: contentView.leftAnchor, constant: 5),
            bookTitleLabel.rightAnchor
                .constraint(equalTo: contentView.rightAnchor, constant: 5),
            bookTitleLabel.bottomAnchor
                .constraint(equalTo: authorNameLabel.topAnchor, constant: -5),
            
            authorNameLabel.leftAnchor
                .constraint(equalTo: contentView.leftAnchor, constant: 5),
            authorNameLabel.rightAnchor
                .constraint(equalTo: contentView.rightAnchor, constant: 5),
            authorNameLabel.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
    func displayBook(_ book: Book) -> Void {
        bookTitleLabel.text = book.title
        authorNameLabel.text = book.authorName?.joined(separator: ", ") ?? ""
    }
}
