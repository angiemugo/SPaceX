//
//  LaunchesListViewController.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import UIKit
import RxCocoa

class LaunchesListViewController: BaseViewController {
    @IBOutlet private var tableView: UITableView!
    var viewModel: LaunchesListViewModel

    init(_ viewModel: LaunchesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ControllerIds.launchesListViewController.rawValue, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchLaunches()
        setUpView()
    }

    private func setUpView() {
        setUpTableView()
        setUpObservables()
        configureNavigationBar("Launches List")
    }

    private func setUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.register(LaunchTableViewCell.identifier)
    }

    private func setUpObservables() {
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.viewModel.showRocket(indexPath)
            }).disposed(by: disposeBag)

        viewModel.loading.subscribe(onNext: { [weak self] loading in
                guard let self = self else { return }
            self.updateLoading(loading, self.view)
            }).disposed(by: disposeBag)

        viewModel.dataSource.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: LaunchTableViewCell.identifier, cellType: LaunchTableViewCell.self)) { _, model, cell in
                cell.configureCell(model)
            }.disposed(by: disposeBag)

        viewModel.errorRelay.subscribe(onNext: { [weak self] error in
            guard let self = self, let error = error else { return }
            self.showErrorView(error, self.view, self.viewModel.fetchLaunches)
        }).disposed(by: disposeBag)
    }
}
