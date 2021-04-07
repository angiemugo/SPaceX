//
//  LaunchErrors.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import Foundation

enum LaunchErrors: Error {
    case parseData
    case timeout
    case apiError(message: String)
    case fileNotFound
}
