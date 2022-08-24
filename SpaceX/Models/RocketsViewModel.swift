//
//  RocketsTableViewModel.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 16.08.2022.
//

import Foundation

struct RocketsTableViewModel {
    let rocketList: [RocketData]
}

extension RocketsTableViewModel {
    func numberOfRowsInSection() -> Int {
        return self.rocketList.count
    }
    
    func rocketsAtIndexPath(_ index: Int) -> RocketsViewModel {
        let rockets = self.rocketList[index]
        return RocketsViewModel(rockets: rockets)
    }
}

struct RocketsViewModel {
    let rockets: RocketData
}

extension RocketsViewModel {
    var rocketsName: String {
        return self.rockets.name
    }
    
    var rocketsImage: [String] {
        return self.rockets.flickr_images
        }
    
    var rocketId: String {
        return self.rockets.id
    }
}
