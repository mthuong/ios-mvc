//
//  UIViewController+Alert.swift
//  iOS MVC
//
//  Created by Thuong Nguyen on 7/4/22.
//

import Foundation
import UIKit

extension UIViewController {
    func alert(_ title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
