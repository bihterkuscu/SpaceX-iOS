//
//  WebService.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 15.08.2022.
//
//
//import Foundation
//
//class Webservice {
//    func downloadRockets(url: URL, completion: @escaping ([RocketData]?) -> ()) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print(error.localizedDescription)
//                completion(nil)
//            } else if let data = data {
//                let rocketsArray = try? JSONDecoder().decode([RocketData].self, from: data)
//                if let rocketsArray = rocketsArray {
//                    completion(rocketsArray)
//                }
//            }
//        }.resume()
//    }
//}
