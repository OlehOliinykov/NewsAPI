//
//  DateFormatters.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import Foundation

private enum DateFormats: String {
    case standartInputFormatDate = "yyyy-MM-dd'T'HH:mm:ssZ"
    case standartOutputFormatDate = "MMM dd, yyyy"
}

final class TimeFormatter {
    static func dateFormatter(date: String?) -> String? {
        guard let date = date else { return nil }
        
        var result = ""
        
        let dateFormatters = DateFormatter()
        dateFormatters.dateFormat = DateFormats.standartInputFormatDate.rawValue
        if let date = dateFormatters.date(from: date) {
            dateFormatters.dateFormat = DateFormats.standartOutputFormatDate.rawValue
            result = dateFormatters.string(from: date)
        }
        return result
    }
    
    static func searchDateFormatter(date: Date) -> String {
        let newFormatter = ISO8601DateFormatter()
        newFormatter.formatOptions = .withFullDate
        let date = newFormatter.string(from: date)
        return date
    }
}
