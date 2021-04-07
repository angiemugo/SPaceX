//
//  BaseRemoteDataSource.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import RxSwift

class BaseRemoteDataSource {
    private let api: APIClient
    
    init() {
        api = APIClient()
    }
    
    func apiRequest<T: Codable>(_ urlRequest: URLRequest) -> Single<(T, HTTPURLResponse)> {
        return api.makeRequest(urlRequest).catch({ error in
            return Single.create(subscribe: { single -> Disposable in
                single(.failure(error))
                return Disposables.create()
            })
        })
    }
}
