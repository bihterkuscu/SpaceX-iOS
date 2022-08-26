//
//  Date.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 21.08.2022.
//

import Foundation

class DateOperations {
    
    static func dateDiff (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    static func convertIS08601(date : String) -> Date{
        let  ISO_8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return DateOperations.dateFormatter(date : date,formatter :ISO_8601)
    }
    
    static func dateFormatter(date: String ,formatter: String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = formatter
        return dateFormatter.date(from:date)!
        
    } 
}
