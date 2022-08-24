//
//  Constants.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 9.08.2022.
//

struct K {
    static let cellIdentifier = "rocketcell"
    static let cellNibName = "RocketViewCell"
    static let registerSegue = "RegisterToApp"
    static let loginSegue = "LoginToApp"
    static let welcometologin = "welcomeToRocket"
}

struct Constants {
    static let baseUrl = "https://api.spacexdata.com/v4/rockets"
}

//The header fields
enum HttpHeaderField: String {
    case contentType = "Content-Type"
}

//The content type (JSON)
enum ContentType: String {
    case json = "application/json"
}

struct FavoritesDB {
    static let collectionName = "Favorites"
    static let userId = "UserUid"
    static let favRocketID = "favRocketID"
    static let rocketImages = "Flicker_images"
    static let rocketName = "RocketName"
    static let favorite = "Favorite"
}
