//
//  UpcomingViewModel.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 19.08.2022.
//

import Foundation

struct UpcomingTableViewModel {
    let upcomingList: [UpcomingData]
}

extension UpcomingTableViewModel {
    func numberOfRowsInSection() -> Int {
        return self.upcomingList.count
    }
    
    func upcomingAtIndexPath(_ index: Int) -> UpcomingViewModel {
        let upcoming = self.upcomingList[index]
        return UpcomingViewModel(upcoming: upcoming)
    }
}

struct UpcomingViewModel {
    
    let upcoming: UpcomingData
}

extension UpcomingViewModel {
    
    var upcomingName: String {
        return self.upcoming.name
    }
    var upcomingImage: String {
        return self.upcoming.links.patch.small!
    }
    var upcomingFlightNumber: Int {
        return self.upcoming.flight_number
    }
    var upcomingDate: String {
        return self.upcoming.date_utc
    }
    var upcomingId: String {
        return self.upcoming.id
    }
}
