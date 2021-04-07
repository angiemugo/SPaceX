//
//  RocketDetailViewModel.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import RxSwift
import RxCocoa

class RocketDetailViewModel {
    let dataSource = BehaviorRelay<RocketResponse?>(value: nil)
    let errorRelay = BehaviorRelay<Error?>(value: nil)
    private var coordinator: RocketDetailCoordinator?
    private let remoteDataSource: LaunchesRemoteDataSourceProtocol
    private let disposeBag = DisposeBag()
    private var rocketId: String?

    init(_ dataSource: LaunchesRemoteDataSourceProtocol) {
        self.remoteDataSource = dataSource
    }

    func setCoordinator(_ coordinator: RocketDetailCoordinator) {
        self.coordinator = coordinator
    }

    func setID(_ id: String) {
        self.rocketId = id
    }

    func fetchRocket() {
        guard let id = rocketId else { return }
        remoteDataSource.getRocket(id).subscribe { [weak self] rocketDetails in
            guard let self = self else { return }
            self.dataSource.accept(rocketDetails)
        } onFailure: { error in
            self.errorRelay.accept(error)
        }.disposed(by: disposeBag)
    }
}
