//
//  UITableView+Extension.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 06/04/2021.
//

import UIKit

extension UITableView {
    func register(_ identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}
