//
//  NewsModel.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import Foundation

struct NewsModel: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Articles]
}

struct Articles: Codable, Hashable, Identifiable {
    var id: String? = UUID().uuidString
    
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: URL?
    let publishedAt: String?
}

struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}
