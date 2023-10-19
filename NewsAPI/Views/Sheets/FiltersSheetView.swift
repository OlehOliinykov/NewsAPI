//
//  FiltersSheetView.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 04.10.2023.
//

import SwiftUI

enum Languages: String, CaseIterable {
    case ar, de, en, es, fr, he, it, nl, no, pt, sv, zh
}

enum SortingParameters: String, CaseIterable {
    case relevancy = "Relevancy"
    case popularity = "Popularity"
    case publishedAt = "Published date"
    
    func getParameter() -> String {
        switch self {
        case .relevancy:
            return "relevancy"
        case .popularity:
            return "popularity"
        case .publishedAt:
            return "publishedAt"
        }
    }
}

enum PageSize: Int, CaseIterable {
    case small = 25
    case medium = 50
    case large = 100
}

enum SearchWordIn: String, CaseIterable {
    case title = "Title"
    case description = "Description"
    case content = "Content"
    
    func getParameter() -> String {
        switch self {
        case .title:
            return "title"
        case .description:
            return "description"
        case .content:
            return "content"
        }
    }
}

enum Constants {
    enum NavigationTitle {
        static let navigationFiltersTitle = "Filters"
    }
    
    enum CornerRadius {
        static let defaultCornerRadius: CGFloat = 8
    }
    
    enum Opacities {
        static let defaultButtonOpacity: Double = 0.25
    }
    
    enum Paddings {
        static let defaultButtonPadding: Double = 7
        static let datePickerPadding: Double = 16
    }
    
    enum SectionTitles {
        static let sortingBySection: String = "Sort news by: "
        static let languageSection: String = "Language: "
        static let searchInSection: String = "Search word in: "
        static let newsInPageSection: String = "News in one page: "
        static let fromSection: String = "Search news from: "
        static let toSection: String = "To: "
    }
}

struct FiltersSheetView: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    @Binding var languages: Languages
    @Binding var sortingParameter: SortingParameters
    @Binding var pageSize: PageSize
    @Binding var searchWordIn: SearchWordIn
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    sortingParameterPicker
                    languagePicker
                    searchWordInPicker
                    pageSizePicker
                    fromDatePicker
                    toDatePicker
                }
            }
            .navigationTitle(Constants.NavigationTitle.navigationFiltersTitle)
        }
    }
    
    private var sortingParameterPicker: some View {
        VStack {
            HStack {
                Text(Constants.SectionTitles.sortingBySection)
                    .bold()
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(SortingParameters.allCases, id: \.self) { parameter in
                        Text(parameter.rawValue)
                            .foregroundColor(.black)
                            .padding(Constants.Paddings.defaultButtonPadding)
                            .background(sortingParameter == parameter ? .gray.opacity(Constants.Opacities.defaultButtonOpacity) : .clear)
                            .cornerRadius(Constants.CornerRadius.defaultCornerRadius)
                            .onTapGesture {
                                withAnimation {
                                    sortingParameter = parameter
                                }
                            }
                    }
                }
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var languagePicker: some View {
        VStack {
            HStack {
                Text(Constants.SectionTitles.languageSection)
                    .bold()
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Languages.allCases, id: \.self) { countryCode in
                        if let formattedLanguage = CountryFormatter.getCountryName(for: countryCode.rawValue) {
                            Text(formattedLanguage)
                                .foregroundColor(.black)
                                .padding(Constants.Paddings.defaultButtonPadding)
                                .background(languages == countryCode ? .gray.opacity(Constants.Opacities.defaultButtonOpacity) : .clear)
                                .cornerRadius(Constants.CornerRadius.defaultCornerRadius)
                                .onTapGesture {
                                    withAnimation {
                                        languages = countryCode
                                    }
                                }
                        }
                    }
                }
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var searchWordInPicker: some View {
        VStack {
            HStack {
                Text(Constants.SectionTitles.searchInSection)
                    .bold()
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(SearchWordIn.allCases, id: \.self) { parameter in
                        Text(parameter.rawValue)
                            .padding(Constants.Paddings.defaultButtonPadding)
                            .background(searchWordIn == parameter ? .gray.opacity(Constants.Opacities.defaultButtonOpacity) : .clear)
                            .cornerRadius(Constants.CornerRadius.defaultCornerRadius)
                            .onTapGesture {
                                withAnimation {
                                    searchWordIn = parameter
                                }
                            }
                    }
                }
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var pageSizePicker: some View {
        VStack {
            HStack {
                Text(Constants.SectionTitles.newsInPageSection)
                    .bold()
                Spacer()
            }
                        
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(PageSize.allCases, id: \.self) { size in
                        Text("\(size.rawValue)")
                            .padding(Constants.Paddings.defaultButtonPadding)
                            .background(pageSize == size ? .gray.opacity(Constants.Opacities.defaultButtonOpacity) : .clear)
                            .cornerRadius(Constants.CornerRadius.defaultCornerRadius)
                            .onTapGesture {
                                withAnimation {
                                    pageSize = size
                                }
                            }
                    }
                }
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var fromDatePicker: some View {
        DatePicker(Constants.SectionTitles.fromSection, selection: $startDate, in: ...endDate, displayedComponents: .date)
            .datePickerStyle(.compact)
            .padding(.horizontal, Constants.Paddings.datePickerPadding)
    }
    
    private var toDatePicker: some View {
        VStack {
            DatePicker(Constants.SectionTitles.toSection, selection: $endDate, in: ...endDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .padding(.horizontal, Constants.Paddings.datePickerPadding)
            Divider()
        }
    }
}
