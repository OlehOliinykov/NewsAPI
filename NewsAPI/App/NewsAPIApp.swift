//
//  NewsAPIApp.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import SwiftUI
import FirebaseCore

@main
struct NewsAPIApp: App {
    @StateObject var news: NewsViewModel = NewsViewModel()
    
    init() {
        FirebaseApp.configure()
        APIKeyFetchService.getAPIKeyFromBackend()
    }
    
    var body: some Scene {
        WindowGroup {
            NewsView(viewModel: news)
        }
    }
}
