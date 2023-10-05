//
//  NewsCell.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import SwiftUI

struct NewsCell: View {
    private enum Constants {
        enum CornerRadius {
            static let defaultCornerRadius: CGFloat = 8
        }
        
        enum LineLimits {
            static let defaultLineLimit: Int = 3
        }
        
        enum Opacities {
            static let defaultOpacity: Double = 0.05
        }
    }
    
    let article: Articles
    var body: some View {
        LazyVStack {
            title
            description
        }
        .background(.gray.opacity(Constants.Opacities.defaultOpacity))
        .cornerRadius(Constants.CornerRadius.defaultCornerRadius)
        .padding()
    }
    
    private var title: some View {
        HStack {
            if let title = article.title {
                Text(title)
                    .foregroundColor(.black)
                    .bold()
                    .padding()
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
    }
    
    private var description: some View {
        HStack {
            if let description = article.description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(Constants.LineLimits.defaultLineLimit)
                    .padding()
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
    }
}

#Preview {
    NewsCell(article: .init(source: Source(id: "id", name: "name"), author: "Author", title: "NHC tracking Tropical Storm Bret, Tropical Depression 4. Forecast path - Palm Beach Post", description: "Tropical Depression Four is expected to become a tropical storm in the next day or so. Next name for the season is Cindy.", urlToImage: URL(string: "URL"), publishedAt: "kolis`!"))
}
