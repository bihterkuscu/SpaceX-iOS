//
//  RocketData.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 10.08.2022.
//

import Foundation

struct RocketsResponseModel: Decodable {
    var flickr_images: [String]
    var description: String
    var id: String
    var name: String
    var type: String
}
