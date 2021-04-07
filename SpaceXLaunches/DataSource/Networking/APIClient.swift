//
//  APIClient.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class APIClient {
    private var sessionManager: Session

    public init() {
        sessionManager = Session()
    }

    func makeRequest<T: Decodable>(_ urlRequest: URLRequest) -> Single<(T, HTTPURLResponse)> {
        return Single.create(subscribe: { [unowned self] (observer) -> Disposable in
            return self.request(urlRequest, { (response, urlResponse) in
                observer(.success((response, urlResponse)))
            }, { (error) in
                observer(.failure(error))
            })
        })
    }

    private func request<T: Decodable>(_ urlRequest: URLRequest,
                                       _ responseHandler: @escaping (T, HTTPURLResponse) -> Void,
                                       _ errorHandler: @escaping ((_ error: LaunchErrors) -> Void)) -> Disposable {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseJSON()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (response) in
                guard let self = self else { return }
                guard let httpUrlResponse = response.response else {
                    return
                }
                let  statusCode = httpUrlResponse.statusCode
                if  200..<300 ~= statusCode {
                    self.decodeResponse(response, responseHandler)
                } else {
                    guard let data = response.data else { return }
                    self.decode(data, statusCode: statusCode, errorHandler)
                }
            }, onFailure: { error in
                errorHandler(.timeout)
            })

        return disposableResponse
    }

    private func decode(_ data: Data, statusCode: Int, _ errorHandler: ((_ error: LaunchErrors) -> Void)) {
        errorHandler(LaunchErrors.apiError(message: statusCode == 401 ? "Not found" : "Error"))
    }

    private func decodeResponse<T: Decodable>(_ response: DataResponse<Any, AFError>,
                                              _ responseHandler: @escaping (T, HTTPURLResponse) -> Void) {
        if let jsonData = response.data, let httpUrlResponse = response.response {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                responseHandler(try decoder.decode(T.self, from: jsonData), httpUrlResponse)
            } catch let error {
                print("Error: \(error) decoding \(T.self)")
            }
        }
    }

}
