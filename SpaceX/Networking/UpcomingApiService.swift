//
//  UpcomingApiService.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 19.08.2022.
//

import Foundation
import UIKit

struct UpcomingManager {
    
    let upcomingURL = "https://api.spacexdata.com/v4/launches/upcoming"
    
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
    func parseJSON(upcomingData: Data) -> Array<UpcomingData> {
        let decoder = JSONDecoder()
        let data = [UpcomingData]()
        do {
            let data = try decoder.decode([UpcomingData].self, from: upcomingData)
            
            return data
        } catch {
            print(error)
        }
        return data
    }
    
    func downloadUpcomings(url: URL, completion: @escaping ([UpcomingData]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
           
            
                let upcomingArray = try? JSONDecoder().decode([UpcomingData].self, from: data)
                if let upcomingArray = upcomingArray {
                    completion(upcomingArray)
                }
            }
        }.resume()
    }
}
