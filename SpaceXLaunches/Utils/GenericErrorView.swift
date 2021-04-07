//
//  GenericErrorView.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 08/04/2021.
//

import UIKit

class GenericErrorView: UIView {
    @IBOutlet private var genericView: UIView!
    @IBOutlet private weak var retryButton: UIButton!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    var retryAction: (() -> Void)?
    var errorMessage: String = "" {
        didSet {
            errorMessageLabel.text = errorMessage
        }
    }

    var retryButtonImage: UIImage? {
        didSet {
            retryButton.setImage(retryButtonImage, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        Bundle.main.loadNibNamed(ViewIds.genericErrorView.rawValue, owner: self, options: nil)
        genericView.frame = self.bounds
        genericView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(genericView)
        errorMessageLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    }

    @IBAction private func retryButtonAction(_ sender: Any) {
        retryAction?()
    }
}
