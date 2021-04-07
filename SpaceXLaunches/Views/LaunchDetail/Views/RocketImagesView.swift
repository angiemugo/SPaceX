//
//  RocketImagesView.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import UIKit

class RocketImagesView: UIView {
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var bannersView: UIView!
    @IBOutlet private weak var bannersScrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    private func loadViewFromNib() {
        view = UINib(nibName: ViewIds.rocketImagesView.rawValue, bundle: nil)
            .instantiate(withOwner: self, options: nil).first as? UIView

        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.masksToBounds = false
        addSubview(view)
    }

    func configure(_ models: [String]) {
        bannersView.layoutSubviews()
        bannersScrollView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        let cellWidth = self.view.frame.size.width
        bannersScrollView.contentSize = CGSize(width: cellWidth * CGFloat(models.count), height: 170)
        bannersScrollView.isUserInteractionEnabled = false
        view.addGestureRecognizer(bannersScrollView.panGestureRecognizer)
        bannersScrollView.delegate = self
        pageControl.numberOfPages = models.count

        let trailingLeadingSpace: CGFloat = 16
        var xPosition: CGFloat = 0.0

        for i in 0..<models.count {
            xPosition = (self.view.frame.size.width * CGFloat(i)) + trailingLeadingSpace
            let shadowView = UIView()
            shadowView.addCornerRadiusAndShadow(10, 0.5)
            shadowView.frame = CGRect(x: xPosition,
                                      y: 4,
                                      width: self.view.frame.size.width - (trailingLeadingSpace * 2),
                                      height: bannersScrollView.frame.height - 8)

            let containerView = UIView()
            containerView.addCornerRadius()
            containerView.layer.masksToBounds = true
            shadowView.addSubview(containerView)
            containerView.pinToSuperview()

            let imageView = UIImageView()
            imageView.load(url: models[i], placeholder: #imageLiteral(resourceName: "placeholder"))
            imageView.contentMode = .scaleAspectFill
            containerView.addSubview(imageView)
            imageView.pinToSuperview()

            bannersScrollView.addSubview(shadowView)
        }
    }
}

// MARK: UIScrollViewDelegate
extension RocketImagesView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let xOffset = scrollView.contentOffset.x
        let scrollWidth = scrollView.bounds.size.width
        pageControl.currentPage = Int(xOffset / scrollWidth)
    }
}
