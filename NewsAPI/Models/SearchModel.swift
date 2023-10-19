//
//  SearchModel.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 19.10.2023.
//

import Foundation

struct SearchModel {
    let searchText: String
    let language: Languages
    let searchIn: SearchWordIn
    let sortParam: SortingParameters
    let from: String
    let to: String
    let page: String
    let pageSize: PageSize
}
