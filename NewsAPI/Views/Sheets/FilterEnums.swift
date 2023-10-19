//
//  FilterEnums.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 19.10.2023.
//

import Foundation

enum Languages: String, CaseIterable, FilterEnum {
    var displayName: String {
        get {
            guard let country = CountryFormatter.getCountryName(for: self.rawValue) else { return "" }
            return country
        }
    }
    
    case ar, de, en, es, fr, he, it, nl, no, pt, sv, zh
}

enum SortingParameters: String, CaseIterable, FilterEnum {
    case relevancy
    case popularity
    case publishedAt
    
    var displayName: String {
        get {
            switch self {
            case .relevancy:
                return "Relevancy"
            case .popularity:
                return "Popularity"
            case .publishedAt:
                return "Published date"
            }
        }
    }
}

enum PageSize: Int, CaseIterable, FilterEnum {
    case small = 25
    case medium = 50
    case large = 100
    
    var displayName: String {
        get {
            switch self {
            case .small:
                return "25"
            case .medium:
                return "50"
            case .large:
                return "100"
            }
        }
    }
}

enum SearchWordIn: String, CaseIterable, FilterEnum {
    case title
    case description
    case content
    
    var displayName: String {
        get {
            switch self {
            case .title:
                return "Title"
            case .description:
                return "Description"
            case .content:
                return "Content"
            }
        }
    }
}
