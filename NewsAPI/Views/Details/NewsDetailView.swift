//
//  NewsDetailView.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import SwiftUI

struct NewsDetailView: View {
    private enum Constants {
        enum NavigationTitle {
            static let navigationDetailTitle = "Detail"
        }
        
        enum CornerRadius {
            static let defaultCornerRadius: CGFloat = 8
        }
        
        enum Spacings {
            static let defaultSpacing: CGFloat = 16
        }
    }
    
    var articles: Articles
    
    var body: some View {
        ScrollView {
            VStack(spacing: Constants.Spacings.defaultSpacing) {
                NewsImage
                NewsDate
                NewsSourceName
                NewsTitle
                NewsDescription
                NewsAuthor
            }
        }
        .navigationTitle(Constants.NavigationTitle.navigationDetailTitle)
        .navigationBarTitleDisplayMode(.large)
    }
    
    @ViewBuilder
    private var NewsImage: some View {
        if let imageUrl = articles.urlToImage {
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(Constants.CornerRadius.defaultCornerRadius)
            } placeholder: {
                ProgressView()
                    .padding()
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private var NewsDate: some View {
        if let date = TimeFormatter.dateFormatter(date: articles.publishedAt) {
            Text(date)
        }
    }
    
    @ViewBuilder
    private var NewsSourceName: some View {
        HStack {
            if let name = articles.source.name {
                Text(name)
                    .padding(.horizontal)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private var NewsTitle: some View {
        HStack {
            if let title = articles.title {
                Text(title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private var NewsDescription: some View {
        if let description = articles.description {
            Text(description)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private var NewsAuthor: some View {
        if let author = articles.author {
            HStack {
                Spacer()
                Text(author)
                    .padding(.horizontal)
            }
        }
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView(articles: .init(source: Source(id: "id", name: "CBS Sports"), author: "Tracey Harrington McCoy", title: "NHC tracking Tropical Storm Bret, Tropical Depression 4. Forecast path - Palm Beach Post", description: "Tropical Depression Four is expected to become a tropical storm in the next day or so. Next name for the season is Cindy.", urlToImage: URL(string: "URL"), publishedAt: "2023-06-21T21:02:00Z"))
    }
}
