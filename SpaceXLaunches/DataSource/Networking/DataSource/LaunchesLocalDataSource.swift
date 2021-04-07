//
//  LaunchesLocalDataSource.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import RxSwift

class LaunchesLocalDataSource: LaunchesRemoteDataSourceProtocol {
    private let jsonLocalDataSource = JsonLocalDataSource()

    func getRocket(_ id: String) -> Single<RocketResponse> {
        return jsonLocalDataSource.read("RocketDetails")
    }

    func getLaunches() -> Single<[LaunchesResponse]> {
        return jsonLocalDataSource.read("Launches")
    }
}
