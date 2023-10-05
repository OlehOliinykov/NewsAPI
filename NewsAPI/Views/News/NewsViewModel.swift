//
//  NewsViewModel.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import Foundation
import Combine

enum NewsSearchStates: CaseIterable {
    case appStart
    case emptyList
    case loaded
    case loading
}

final class NewsViewModel: ObservableObject {
    @Published var newsState: NewsSearchStates = .appStart
    
    @Published var news = [Articles]()
    
    @Published var searchText: String = ""
    
    @Published var currentPage: Int = 1
    @Published var language: Languages = .en
    @Published var pageSize: PageSize = .small
    @Published var searchIn: SearchWordIn = .title
    @Published var sortingParameter: SortingParameters = .publishedAt
    @Published var startDate: Date = (Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
    @Published var endDate: Date = .now
    
    @Published var showFiltersSheet: Bool = false
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var offset: Int = 0
    @Published var isLoadedAll: Bool = false
    
    private var totalResults: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadMoreNews() {
        if !isLoadedAll {
            findNews(for: searchText)
        }
    }
    
    func startSearch() {
        news.removeAll()
        currentPage = 1
        isLoadedAll = false
        findNews(for: searchText)
    }
    
    private func findNews(for searchText: String) {
        guard !searchText.isEmpty else { return }
                
        offset = currentPage * pageSize.rawValue
        
        newsState = .loading
        
        NewsService.findNewsPublisher(searchText,
                                      languages: language,
                                      searchIn: searchIn,
                                      sortParam: sortingParameter,
                                      from: TimeFormatter.searchDateFormatter(date: startDate),
                                      to: TimeFormatter.searchDateFormatter(date: endDate), 
                                      page: String(currentPage),
                                      pageSize: pageSize)
        .receive(on: DispatchQueue.global(qos: .background))
        .sink { [weak self] result in
            guard let self else { return }
            self.handleResult(result)
            
        } receiveValue: { [weak self] response in
            guard let self else { return }
            self.handleResponse(response)
        }
        .store(in: &cancellables)
    }
    
    private func handleResponse(_ response: NewsModel) {
        DispatchQueue.main.async {
            if response.articles.count < self.pageSize.rawValue {
                self.isLoadedAll = true
            }
            self.news.append(contentsOf: response.articles)
            self.currentPage += 1
            self.newsState = self.news.isEmpty ? .emptyList : .loaded
        }
    }
    
    private func handleResult(_ result: Subscribers.Completion<Error>) {
        switch result {
        case .finished:
            break
        case .failure(_):
            DispatchQueue.main.async {
                self.showAlert = true
                self.alertMessage = "Something went wrong"
            }
        }
    }
}
