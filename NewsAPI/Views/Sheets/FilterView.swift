//
//  FilterView.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 19.10.2023.
//

import SwiftUI

protocol FilterEnum: Hashable, CaseIterable where AllCases == Array<Self> {
    var displayName: String { get }
}

struct FilterView<T: FilterEnum>: View where T.AllCases == Array<T> {
    @Binding var selectedFilter: T
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(T.allCases, id: \.self) { filter in
                    Text(filter.displayName)
                        .padding(Constants.Paddings.defaultButtonPadding)
                        .background(selectedFilter == filter ? .gray.opacity(Constants.Opacities.defaultButtonOpacity) : .clear)
                        .cornerRadius(Constants.CornerRadius.defaultCornerRadius)
                        .onTapGesture {
                            withAnimation {
                                selectedFilter = filter
                            }
                        }
                }
            }
        }
    }
}
