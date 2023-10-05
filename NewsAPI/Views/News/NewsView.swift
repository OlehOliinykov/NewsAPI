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
            static let navigationDetailTitle = "Detail"
        }
        
        enum CornerRadius {
            static let defaultCornerRadius: CGFloat = 8
        }
    }
    
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
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
            .navigationTitle("News")
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
    
    private var searchField: some View {
        TextField("Search", text: $viewModel.searchText)
            .textFieldStyle(.roundedBorder)
            .padding(.leading)
    }
    
    private var searchButton: some View {
        Button("Search") {
            viewModel.news.removeAll()
            viewModel.findNews()
        }
        .foregroundColor(.white)
        .padding(7)
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
    
    private var startMessage: some View {
        VStack {
            Spacer()
            Text("Let`s find some news")
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    private var emptyList: some View {
        VStack {
            Spacer()
            Text("Oops...\nlooks like we couldn't find anything")
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    private var newsList: some View {
        VStack{
            ForEach(viewModel.news, id: \.self) { news in
                NavigationLink {
                    NewsDetailView(articles: news)
                } label: {
                    NewsCell(article: news)
                }
            }
        }
    }
    
    private var progressView: some View {
        VStack {
            Spacer()
            ProgressView {
                Text("Trying find something for you...")
            }
            Spacer()
        }
    }
}

#Preview {
    NewsView(viewModel: NewsViewModel())
}

