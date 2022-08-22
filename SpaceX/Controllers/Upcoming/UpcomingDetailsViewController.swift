//
//  UpcomingDetailsViewController.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 19.08.2022.
//

import UIKit

class UpcomingDetailsViewController: UIViewController {

    @IBOutlet weak var upcomingImg: UIImageView!
    @IBOutlet weak var upcomingName: UILabel!
    @IBOutlet weak var flightNumber: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var upcomingId: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var totalSecond = Int()
    var timer:Timer?

    
    var upcomingData :UpcomingData = UpcomingData(flight_number: 0, name: "", date_utc: "", id: "", links: UpcomingData.Links(patch: UpcomingData.Patch(small: "")))
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start timer
        startTimer()

        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "spaceXIOsBg")!)
        
        self.upcomingName.text="Name : " + upcomingData.name
        self.flightNumber.text="Flight Number : " + String(upcomingData.flight_number)
        self.date.text=upcomingData.date_utc
        self.upcomingId.text="Id : " + upcomingData.id
        self.upcomingImg.loads(urlString: upcomingData.links.patch.small ?? "")
    }
    
    
    func startTimer(){
        
        let upcomingDate = DateOperations.convertIS08601(date: upcomingData.date_utc)
        self.totalSecond = Int(DateOperations.dateDiff(lhs: upcomingDate, rhs: Date()))
        
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }

    @objc func countdown() {
        var hours: Int
        var minutes: Int
        var seconds: Int
        var day: Int
        
        if totalSecond == 0 {
            timer?.invalidate()
            timerLabel.text="Launched!"
            
        } else {
            totalSecond = totalSecond - 1
            day = (totalSecond / 3600) / 24
            hours = (totalSecond / 3600) % 24
            minutes = (totalSecond % 3600) / 60
            seconds = (totalSecond % 3600) % 60
            timerLabel.text = String(format: "%02d day %02d hour %02d minute %02d second", day, hours, minutes, seconds)
        }
       
    }


}


