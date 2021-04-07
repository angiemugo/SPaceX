//
//  BaseViewController.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 06/04/2021.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    private var genericErrorView: GenericErrorView?
    private var loadingView: UIView?
    var disposeBag = DisposeBag()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func updateLoading(_ show: Bool, _ view: UIView) {
        if show {
            showLoading(view)
        } else {
            hideLoading(view)
        }
    }

    private func hideLoading(_ view: UIView) {
        if let loadingView = loadingView, view.subviews.contains(loadingView) {
            loadingView.removeFromSuperview()
        }
    }

    func configureNavigationBar(_ title: String?) {
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = title
    }

    private func showLoading(_ view: UIView) {
        if loadingView == nil {
            loadingView = LoadingView(frame: view.bounds)
        }
        guard let loadingView = loadingView, !view.subviews.contains(loadingView) else {
            return
        }
        view.addSubview(loadingView)
        loadingView.pinToSuperview()
    }

    func showErrorView(_ error: Error, _ view: UIView, _ retryAction: @escaping () -> Void) {
        if genericErrorView == nil {
            genericErrorView = GenericErrorView(frame: view.bounds)
        }
        genericErrorView?.errorMessage = error.localizedDescription
        genericErrorView?.retryAction = {[unowned self] in
            self.removeErrorView(view)
            retryAction()
        }
        if !view.subviews.contains(genericErrorView!) {
            view.addSubview(genericErrorView!)
            genericErrorView?.pinToSuperview()
        }
    }

    private func removeErrorView(_ view: UIView) {
        if genericErrorView != nil && view.subviews.contains(genericErrorView!) {
            genericErrorView?.removeFromSuperview()
        }
    }
}
