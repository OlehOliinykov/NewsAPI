//
//  ContentView.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import SwiftUI

struct NewsView: View {
    private enum Constants {
        enum NavigationTitle {
            static let navigationNewsTitle = "News"
        }
        
        enum CornerRadius {
            static let defaultCornerRadius: CGFloat = 8
        }
        
        enum Messages {
            static let startAppMessage: String = "Let`s find some news"
            static let searchingNewsMessage: String = "Trying find something for you..."
            static let emptyListMessage: String = "Oops...\nlooks like we couldn't find anything"
        }
        
        enum Placeholders {
            static let searchPlaceholderText: String = "Search"
            static let okPlaceholderText: String = "OK"
        }
        
        enum Paddings {
            static let defaultButtonPadding: Double = 7
        }
    }
    
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        searchField
                        searchButton
                    }
                    Divider()
                    resultView
                }
            }
            .sheet(isPresented: $viewModel.showFiltersSheet, content: {
                FiltersSheetView(startDate: $viewModel.startDate,
                                 endDate: $viewModel.endDate, languages: $viewModel.language,
                                 sortingParameter: $viewModel.sortingParameter,
                                 pageSize: $viewModel.pageSize,
                                 searchWordIn: $viewModel.searchIn)
            })
            .toolbar {
                Button {
                    viewModel.showFiltersSheet.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
            .navigationTitle(Constants.NavigationTitle.navigationNewsTitle)
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button(Constants.Placeholders.okPlaceholderText, role: .cancel) { }
            }
        }
    }
    
    private var searchField: some View {
        TextField(Constants.Placeholders.searchPlaceholderText, text: $viewModel.searchText)
            .textFieldStyle(.roundedBorder)
            .padding(.leading)
    }
    
    private var searchButton: some View {
        Button(Constants.Placeholders.searchPlaceholderText) {
            viewModel.startSearch()         
        }
        .foregroundColor(.white)
        .padding(Constants.Paddings.defaultButtonPadding)
        .background(.blue)
        .cornerRadius(Constants.CornerRadius.defaultCornerRadius)
        .padding(.trailing)
    }
    
    @ViewBuilder
    private var resultView: some View {
        switch viewModel.newsState {
        case .appStart:
            startMessage
        case .emptyList:
            emptyList
        case .loaded:
            newsList
        case .loading:
            progressView
        }
    }
    
    private var newsList: some View {
        VStack {
            ForEach(viewModel.news, id: \.self) { news in
                NavigationLink {
                    NewsDetailView(articles: news)
                } label: {
                    NewsCell(article: news)
                }
            }
            if !viewModel.news.isEmpty {
                LazyVStack {
                    LoadMoreDataIfNeededView(array: viewModel.news,
                                             offset: $viewModel.offset,
                                             isLoadedAll: viewModel.isLoadedAll,
                                             onLoadMore: viewModel.loadMoreNews)
                }
            }
        }
    }
    
    private var startMessage: some View {
        VStack {
            Spacer()
            Text(Constants.Messages.startAppMessage)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    private var emptyList: some View {
        VStack {
            Spacer()
            Text(Constants.Messages.emptyListMessage)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
        
    private var progressView: some View {
        VStack {
            Spacer()
            ProgressView {
                Text(Constants.Messages.searchingNewsMessage)
            }
            .progressViewStyle(.circular)
            Spacer()
        }
    }
}


#Preview {
    NewsView(viewModel: NewsViewModel())
}

