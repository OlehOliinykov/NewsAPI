//
//  NewsService.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import Combine
import Foundation
import KeychainSwift

final class NewsService {
    private enum Constants {
        enum WeatherServiceErrors {
            static let createURLError: String = "Fail when try create URL"
        }
    }
    static private let keychain = KeychainSwift()
    
    static func findNewsPublisher(_ q: String, languages: Languages, searchIn: SearchWordIn, sortParam: SortingParameters, from: String, to: String, page: String, pageSize: PageSize) -> AnyPublisher<NewsModel, Error> {
        let session = URLSession.shared
        let decoder = JSONDecoder()

        let url = createURL(q: q, language: languages, searchIn: searchIn, sortParam: sortParam, pageSize: pageSize, from: from, to: to, page: page, key: keychain.get("APIKey"))

        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsModel.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
        
    private static func createURL(q: String,
                                  language: Languages,
                                  searchIn: SearchWordIn,
                                  sortParam: SortingParameters,
                                  pageSize: PageSize,
                                  from: String,
                                  to: String,
                                  page: String,
                                  key: String?) -> URL {
        guard let key = key else { return URL(string: Constants.WeatherServiceErrors.createURLError.description)! }
        var component = URLComponents()
        component.scheme = "https"
        component.host = "newsapi.org"
        component.path = "/v2/everything"
        component.queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "pageSize", value: "\(pageSize.rawValue)"),
            URLQueryItem(name: "language", value: language.rawValue),
            URLQueryItem(name: "searchIn", value: searchIn.getParameter()),
            URLQueryItem(name: "sortBy", value: sortParam.getParameter()),
            URLQueryItem(name: "from", value: from),
            URLQueryItem(name: "to", value: to),
            URLQueryItem(name: "page", value: page),
            URLQueryItem(name: "apiKey", value: key)
        ]
        
        guard let url = component.url else { return URL(string: Constants.WeatherServiceErrors.createURLError.description)! }
        print("URL: \(url)")
        return url
    }
}
