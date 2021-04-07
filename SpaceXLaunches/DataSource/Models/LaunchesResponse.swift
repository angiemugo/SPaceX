//
//  LaunchesResponse.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import Foundation

struct LaunchesResponse: Codable {
    let rocketId: String
    let launchNumber: Int
    let details: String
    let date: Date
    let upcomingLaunch: Bool
    let isSuccessful: Bool

    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket"
        case launchNumber = "flight_number"
        case details
        case date = "date_local"
        case upcomingLaunch = "upcoming"
        case isSuccessful = "success"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        rocketId = try container.decode(String.self, forKey: .rocketId)
        launchNumber = try container.decode(Int.self, forKey: .launchNumber)
        details = try container.decodeIfPresent(String.self, forKey: .details) ?? ""
        date = try container.decode(Date.self, forKey: .date)
        upcomingLaunch = try container.decode(Bool.self, forKey: .upcomingLaunch)
        isSuccessful = try container.decodeIfPresent(Bool.self, forKey: .isSuccessful) ?? false
    }
}
