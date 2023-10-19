//
//  NewsService.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import Combine
import Foundation

final class NewsService {
    private enum Constants {
        enum WeatherServiceErrors {
            static let createURLError: String = "Fail when try create URL"
        }
    }
    
    static func findNewsPublisher(with searchModel: SearchModel) -> AnyPublisher<NewsModel, Error> {
        let session = URLSession.shared
        let decoder = JSONDecoder()

        let url = createURL(with: searchModel, key: KeyChainService.getAPIKey())

        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsModel.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
        
    private static func createURL(with searchModel: SearchModel, key: String?) -> URL {
        guard let key = key else { return URL(string: Constants.WeatherServiceErrors.createURLError.description)! }
        var component = URLComponents()
        component.scheme = "https"
        component.host = "newsapi.org"
        component.path = "/v2/everything"
        component.queryItems = [
            URLQueryItem(name: "q", value: searchModel.searchText),
            URLQueryItem(name: "pageSize", value: "\(searchModel.pageSize.rawValue)"),
            URLQueryItem(name: "language", value: searchModel.language.rawValue),
            URLQueryItem(name: "searchIn", value: searchModel.searchIn.getParameter()),
            URLQueryItem(name: "sortBy", value: searchModel.sortParam.getParameter()),
            URLQueryItem(name: "from", value: searchModel.from),
            URLQueryItem(name: "to", value: searchModel.to),
            URLQueryItem(name: "page", value: searchModel.page),
            URLQueryItem(name: "apiKey", value: key)
        ]
        
        guard let url = component.url else { return URL(string: Constants.WeatherServiceErrors.createURLError.description)! }
        print("URL: \(url)")
        return url
    }
}
