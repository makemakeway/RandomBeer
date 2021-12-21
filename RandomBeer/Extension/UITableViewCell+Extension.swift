//
//  UITableViewCell+Extension.swift
//  RandomBeer
//
//  Created by 박연배 on 2021/12/21.
//

import UIKit


protocol Reusable {
    static var reuseIdentifier: String {
        get
    }
}

extension UITableViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

