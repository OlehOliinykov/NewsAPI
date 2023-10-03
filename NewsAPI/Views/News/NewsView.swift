//
//  ContentView.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 03.10.2023.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    NewsView(viewModel: NewsViewModel())
}