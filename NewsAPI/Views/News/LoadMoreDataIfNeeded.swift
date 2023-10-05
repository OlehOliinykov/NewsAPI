//
//  LoadMoreDataIfNeeded.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 05.10.2023.
//

import SwiftUI

struct LoadMoreDataIfNeededView<T: Identifiable>: View {
    let array: [T]
    @Binding var offset: Int
    let isLoadedAll: Bool
    let onLoadMore: () -> Void
    
    var body: some View {
        if offset == array.count {
            return AnyView(
                ProgressView()
                    .padding(.vertical)
                    .opacity(isLoadedAll ? 0 : 1)
                    .onAppear {
                        withAnimation {
                            onLoadMore()
                        }
                    }
            )
        } else {
            return AnyView(
                GeometryReader { reader -> Color in
                    let minY = reader.frame(in: .global).minY
                    let height = UIScreen.main.bounds.height / 1.3
                    
                    if !array.isEmpty && minY < height {
                        DispatchQueue.main.async {
                            withAnimation {
                                offset = array.count
                                onLoadMore()
                            }
                        }
                    }
                    return Color.clear
                }
                .frame(width: 20, height: 20)
            )
        }
    }
}
