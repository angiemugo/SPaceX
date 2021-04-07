//
//  LaunchTableViewCell.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 06/04/2021.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    @IBOutlet private var launchNumberLabel: UILabel!
    @IBOutlet private var detailsLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var isUpcomingLabel: UILabel!

    func configureCell(_ model: LaunchTableViewCell.UIModel) {
        launchNumberLabel.text = "Launch No: \(model.launchNumber)"
        detailsLabel.text = model.details
        dateLabel.text = model.dateString
        isUpcomingLabel.isHidden = !model.isUpcoming
        selectionStyle = .none
    }
}

extension LaunchTableViewCell {
    struct UIModel {
        let id: String
        let launchNumber: String
        let details: String
        let dateString: String
        let isUpcoming: Bool
    }
}
