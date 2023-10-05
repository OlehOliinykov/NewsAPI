@_private(sourceFile: "NewsView.swift") import NewsAPI
import func SwiftUI.__designTimeBoolean
import func SwiftUI.__designTimeInteger
import protocol SwiftUI.PreviewProvider
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeFloat
import struct SwiftUI.EmptyView
import protocol SwiftUI.View
import SwiftUI

extension LoadMoreDataIfNeededView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/NewsAPI/NewsAPI/Views/News/NewsView.swift", line: 133)
        if offset == array.count {
            return AnyView(
                ProgressView()
                    .padding(.vertical)
                    .opacity(isLoadedAll ? __designTimeInteger("#1272.[2].[4].property.[0].[0].[0].[0].arg[0].value.modifier[1].arg[0].value.then", fallback: 0) : __designTimeInteger("#1272.[2].[4].property.[0].[0].[0].[0].arg[0].value.modifier[1].arg[0].value.else", fallback: 1))
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
                    let height = UIScreen.main.bounds.height / __designTimeFloat("#1272.[2].[4].property.[0].[0].[1].[0].arg[0].value.arg[0].value.[1].value.[0]", fallback: 1.3)
                    
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
                .frame(width: __designTimeInteger("#1272.[2].[4].property.[0].[0].[1].[0].arg[0].value.modifier[0].arg[0].value", fallback: 20), height: __designTimeInteger("#1272.[2].[4].property.[0].[0].[1].[0].arg[0].value.modifier[0].arg[1].value", fallback: 20))
            )
        }
    
#sourceLocation()
    }
}

extension NewsView {
    @_dynamicReplacement(for: progressView) private var __preview__progressView: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/NewsAPI/NewsAPI/Views/News/NewsView.swift", line: 116)
        VStack {
            Spacer()
            ProgressView {
                Text(__designTimeString("#1272.[1].[9].property.[0].[0].arg[0].value.[1].arg[0].value.[0].arg[0].value", fallback: "Trying find something for you..."))
            }
            Spacer()
        }
    
#sourceLocation()
    }
}

extension NewsView {
    @_dynamicReplacement(for: newsList) private var __preview__newsList: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/NewsAPI/NewsAPI/Views/News/NewsView.swift", line: 100)
        VStack{
            ForEach(viewModel.news, id: \.self) { news in
                NavigationLink {
                    NewsDetailView(articles: news)
                } label: {
                    NewsCell(article: news)
                }
            }
//            LoadMoreDataIfNeededView(array: viewModel.news,
//                                     offset: $viewModel.offset,
//                                     isLoadedAll: viewModel.isLoadedAll,
//                                     onLoadMore: viewModel.findNews)
        }
    
#sourceLocation()
    }
}

extension NewsView {
    @_dynamicReplacement(for: emptyList) private var __preview__emptyList: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/NewsAPI/NewsAPI/Views/News/NewsView.swift", line: 95)
        Text("Oops...\nlooks like we couldn't find anything")
            .multilineTextAlignment(.center)
    
#sourceLocation()
    }
}

extension NewsView {
    @_dynamicReplacement(for: startMessage) private var __preview__startMessage: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/NewsAPI/NewsAPI/Views/News/NewsView.swift", line: 90)
        Text(__designTimeString("#1272.[1].[6].property.[0].[0].arg[0].value", fallback: "Let`s find some news"))
            .multilineTextAlignment(.center)
    
#sourceLocation()
    }
}

extension NewsView {
    @_dynamicReplacement(for: resultView) @ViewBuilder private var __preview__resultView: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/NewsAPI/NewsAPI/Views/News/NewsView.swift", line: 77)
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
    
#sourceLocation()
    }
}

extension NewsView {
    @_dynamicReplacement(for: searchButton) private var __preview__searchButton: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/NewsAPI/NewsAPI/Views/News/NewsView.swift", line: 65)
        Button(__designTimeString("#1272.[1].[4].property.[0].[0].arg[0].value", fallback: "Search")) {
            viewModel.findNews()
        }
        .foregroundColor(.white)
        .padding(__designTimeInteger("#1272.[1].[4].property.[0].[0].modifier[1].arg[0].value", fallback: 7))
        .background(.blue)
        .cornerRadius(Constants.CornerRadius.defaultCornerRadius)
        .padding(.trailing)
    
#sourceLocation()
    }
}

extension NewsView {
    @_dynamicReplacement(for: searchField) private var __preview__searchField: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/NewsAPI/NewsAPI/Views/News/NewsView.swift", line: 59)
        TextField(__designTimeString("#1272.[1].[3].property.[0].[0].arg[0].value", fallback: "Search"), text: $viewModel.searchText)
            .textFieldStyle(.roundedBorder)
            .padding(.leading)
    
#sourceLocation()
    }
}

extension NewsView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/NewsAPI/NewsAPI/Views/News/NewsView.swift", line: 24)
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
                    Image(systemName: __designTimeString("#1272.[1].[2].property.[0].[0].arg[0].value.[0].modifier[1].arg[0].value.[0].arg[1].value.[0].arg[0].value", fallback: "line.3.horizontal.decrease.circle"))
                }
            }
            .navigationTitle(__designTimeString("#1272.[1].[2].property.[0].[0].arg[0].value.[0].modifier[2].arg[0].value", fallback: "News"))
            .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                Button(__designTimeString("#1272.[1].[2].property.[0].[0].arg[0].value.[0].modifier[3].arg[2].value.[0].arg[0].value", fallback: "OK"), role: .cancel) { }
            }
        }
    
#sourceLocation()
    }
}

import struct NewsAPI.NewsView
import struct NewsAPI.LoadMoreDataIfNeededView
#Preview {
    NewsView(viewModel: NewsViewModel())
}

// Support for back-deployment.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, xrOS 1.0, *)
struct RegistryCompatibilityProvider_line_192: SwiftUI.PreviewProvider {
    static var previews: some SwiftUI.View {
        #if os(iOS)
        let __makePreview: () -> any SwiftUI.View = {
            NewsView(viewModel: NewsViewModel())
        }
        SwiftUI.VStack {
            SwiftUI.AnyView(__makePreview())
        }
        #else
        // The preview is not available.
        SwiftUI.EmptyView()
        #endif
    }
}




