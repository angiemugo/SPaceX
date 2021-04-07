//
//  LaunchesListViewModel.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import Foundation
import RxSwift
import RxCocoa

class LaunchesListViewModel {
    private var coordinator: LaunchesListViewCoordinator?
    let dataSource = BehaviorRelay(value: [LaunchTableViewCell.UIModel]())
    let loading = BehaviorRelay(value: true)
    let errorRelay = BehaviorRelay<Error?>(value: nil)
    let remoteDataSource: LaunchesRemoteDataSourceProtocol
    private let disposeBag = DisposeBag()

    init(_ dataSource: LaunchesRemoteDataSourceProtocol) {
        self.remoteDataSource = dataSource
    }

    func setCoordinator(_ coordinator: LaunchesListViewCoordinator) {
        self.coordinator = coordinator
    }

    func fetchLaunches() {
        remoteDataSource.getLaunches().subscribe { [weak self] launches in
            guard let self = self else { return }
            self.loading.accept(false)
            self.getUIModel(launches)
        } onFailure: { error in
            self.errorRelay.accept(error as? LaunchErrors)
        }.disposed(by: disposeBag)
    }

    func getUIModel(_ model: [LaunchesResponse]) {
        let filtered = model.filter { $0.upcomingLaunch || $0.isSuccessful }
        let data = filtered.map { launch -> LaunchTableViewCell.UIModel in
            return LaunchTableViewCell.UIModel(id: launch.rocketId,
                                               launchNumber: "\(launch.launchNumber)",
                                               details: launch.details,
                                               dateString: launch.date.getFormattedDate(),
                                               isUpcoming: launch.upcomingLaunch)
        }
        dataSource.accept(data)
    }

    func showRocket(_ indexPath: IndexPath) {
        let id = dataSource.value[indexPath.row].id
        coordinator?.showRocketDetails(id)
    }
}
