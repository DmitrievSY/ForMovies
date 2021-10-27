// UIViewController+Extension.swift
// Copyright © DmitrievSY. All rights reserved.

import UIKit

extension UIViewController {
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
