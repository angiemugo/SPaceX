//
//  RocketResponse.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 05/04/2021.
//

import Foundation

struct RocketResponse: Codable {
    let name: String
    let images: [String]
    let description: String
    let wikipediaLink: String

    enum CodingKeys: String, CodingKey {
        case name
        case images = "flickr_images"
        case description
        case wikipediaLink = "wikipedia"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        images = try container.decode([String].self, forKey: .images)
        description = try container.decode(String.self, forKey: .description)
        wikipediaLink = try container.decode(String.self, forKey: .wikipediaLink)
    }
}
