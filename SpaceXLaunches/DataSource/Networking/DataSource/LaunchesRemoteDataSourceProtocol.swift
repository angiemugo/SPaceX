//
//  LaunchesRemoteDataSourceProtocol.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import RxSwift

protocol LaunchesRemoteDataSourceProtocol {
    func getRocket(_ id: String) -> Single<RocketResponse>
    func getLaunches() -> Single<[LaunchesResponse]>
}
