//
//  JsonLocalDataSource.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import RxSwift

class JsonLocalDataSource {
    func read<T: Decodable>(_ fileName: String) -> Single<T> {
        return Single.create(subscribe: { (observer) -> Disposable in
            if let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    observer(.success(try decoder.decode(T.self, from: data)))
                } catch {
                    observer(.failure(error))
                }
            } else {
                observer(.failure(LaunchErrors.fileNotFound))
            }
            return Disposables.create()
        })
    }
}
