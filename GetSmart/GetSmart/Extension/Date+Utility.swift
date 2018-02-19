//
//  Date+Utility.swift
//  FoodTruckAndBeer
//
//  Created by Abhinay Maurya on 15/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

extension Date
{
    func string() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
    func milliSec() -> Int{
        let sec = Int(self.timeIntervalSince1970)
        return sec
    }
    
    func getADayAfter(xDay:Int) -> Date
    {
        let interval = TimeInterval(60 * 60 * 24 * xDay)
        return self.addingTimeInterval(interval)
    }
    
    static func getDayAtMidNight(date:Date) -> Date
    {
        let calendar = Calendar.current
        var comps = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: date)
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        
        let midnightOfToday = calendar.date(from: comps)
        return midnightOfToday!
    }
    
}

extension String
{
    func getDayName() -> String{
        //Friday February 17, 2017
        let components = self.components(separatedBy: " ")
        return components[0]//Friday
    }
}
