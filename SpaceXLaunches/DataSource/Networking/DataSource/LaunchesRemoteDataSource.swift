//
//  LaunchesRemoteDataSource.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import Foundation
import RxSwift

class LaunchesRemoteDataSource: BaseRemoteDataSource, LaunchesRemoteDataSourceProtocol {
    func getRocket(_ id: String) -> Single<RocketResponse> {
        return requestGetRocket(id).map { $0.0 }
    }

    func getLaunches() -> Single<[LaunchesResponse]> {
        return requestGetLaunches().map { $0.0 }
    }

    private func requestGetRocket(_ id: String) -> Single<(RocketResponse, HTTPURLResponse)> {
        let urlRequest = URLRequest(.rockets, .get, id)
        return apiRequest(urlRequest)
    }

    private func requestGetLaunches() -> Single<([LaunchesResponse], HTTPURLResponse)> {
        let urlRequest = URLRequest(.launches, .get)
        return apiRequest(urlRequest)
    }
}
