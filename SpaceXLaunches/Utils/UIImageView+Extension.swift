//
//  UIImageView+Extension.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import UIKit

extension UIImageView {
    func load(url: String, placeholder: UIImage) {
        DispatchQueue.main.async {
            self.addActivityIndicator()
        }
        guard let url = URL(string: url) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.removeActivityIndicator()
            }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                } else {
                    self.image = placeholder
                }
            }
        }
    }
    
    func addActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func removeActivityIndicator() {
        let activityView = subviews.filter { $0.isKind(of: UIActivityIndicatorView.self)}.first
        activityView?.removeFromSuperview()
    }
}
