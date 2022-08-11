//
//  RocketManager.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 10.08.2022.
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
                
                if let safeData = data {
                    parseJSON(rocketData: safeData)
                }
            }
            
            //4. Start  the task
            task.resume()
        }
    }
    
    func parseJSON(rocketData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([RocketsResponseModel].self, from: rocketData)
            print(decodedData)
        } catch {
            print(error)
        }
    }
}
