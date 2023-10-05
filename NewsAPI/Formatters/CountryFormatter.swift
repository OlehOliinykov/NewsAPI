//
//  Сщгтеек.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 04.10.2023.
//

import Foundation

final class CountryFormatter {
    static func getCountryName(for countryCode: String) -> String? {
        let locale = Locale(identifier: "en_US")
        let countryName = locale.localizedString(forLanguageCode: countryCode)
        
        return countryName
    }
}
