//
//  ApiService.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 15.08.2022.
//

import Foundation
import UIKit

struct RocketManager {
    
    let rocketURL = "https://api.spacexdata.com/v4/rockets"
    
    func performRequest(with urlString: String) {
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give  the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
            }
            
            //4. Start  the task
            task.resume()
        }
    }
    func parseJSON(rocketData: Data) -> Array<RocketData> {
        let decoder = JSONDecoder()
        let data = [RocketData]()
        do {
            let data = try decoder.decode([RocketData].self, from: rocketData)
            return data
        } catch {
            print(error)
        }
        return data
    }
    
    func downloadRockets(url: URL, completion: @escaping ([RocketData]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let rocketsArray = try? JSONDecoder().decode([RocketData].self, from: data)
                if let rocketsArray = rocketsArray {
                    completion(rocketsArray)
                }
            }
        }.resume()
    }
}
