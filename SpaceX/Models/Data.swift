//
//  RocketData.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 10.08.2022.
//


import Foundation

struct RocketData: Decodable {
    let flickr_images: [String]
    let description: String
    let id: String
    let name: String
    let type: String
}

struct UpcomingData: Decodable {
    let flight_number: Int
    let name: String
    let date_utc: String
    let id: String
    let links: Links
    

    struct Links: Decodable {
        let patch: Patch

   }

    struct Patch: Decodable {
       let small : String?
       
   }
}


