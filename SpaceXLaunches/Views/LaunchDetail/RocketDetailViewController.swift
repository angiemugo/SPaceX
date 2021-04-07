//
//  RocketDetailViewController.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import UIKit

class RocketDetailViewController: BaseViewController {
    @IBOutlet private var rocketName: UILabel!
    @IBOutlet private var rocketImage: RocketImagesView!
    @IBOutlet private var rocketDescription: UILabel!
    @IBOutlet private var rocketWikipediaLink: UITextView!
    
    var viewModel: RocketDetailViewModel
    
    init(_ viewModel: RocketDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ControllerIds.rocketDetailViewController.rawValue, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRocket()
        setUpObservables()
        configureNavigationBar("Rocket details")
    }
    
    func setUpView(_ model: RocketResponse) {
        rocketName.text = model.name
        rocketImage.configure(model.images)
        rocketDescription.text = model.description
        getLink(model.wikipediaLink)
    }
    
    func getLink(_ urlString: String) {
        let fontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let attributedString = NSMutableAttributedString(string: "Wikipedia link: \(urlString)", attributes: fontAttribute)
        guard let url = URL(string: urlString) else { return }
        attributedString.addAttribute(.link, value: url, range: NSRange(location: 16, length: urlString.count))
        rocketWikipediaLink.attributedText = attributedString
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    private func setUpObservables() {
        viewModel.dataSource.subscribe(onNext: { [weak self] data in
            guard let self = self, let data = data else { return }
            self.setUpView(data)
        }).disposed(by: disposeBag)

        viewModel.errorRelay.subscribe(onNext: { [weak self] error in
            guard let self = self, let error = error else { return }
            self.showErrorView(error, self.view, self.viewModel.fetchRocket)
        }).disposed(by: disposeBag)
    }
}
