//
//  Date+Extension.swift
//  SpaceXLaunches
//
//  Created by Angie Mugo on 07/04/2021.
//

import Foundation

extension Date {
    func getFormattedDate() -> String {
        return "\(getFormattedDay()), \(getFormattedHour())"
    }

    func getFormattedDay() -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM, yyyy"
            return dateFormatter.string(from: self)
        }
    }

    func getFormattedHour() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
}
