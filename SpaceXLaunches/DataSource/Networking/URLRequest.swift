//
//  URLRequest.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import Foundation

extension URLRequest {
    init(_ endPoint: APIEndPoint, _ method: APIMethod, _ urlArgs: CVarArg...) {
        let baseURL = "https://api.spacexdata.com/v4"
        let path = String(format: endPoint.rawValue, arguments: urlArgs)
        let urlString = "\(baseURL)\(path)"
        let url = URL(string: urlString)!
        self.init(url: url)
        httpMethod = method.rawValue
    }
}
