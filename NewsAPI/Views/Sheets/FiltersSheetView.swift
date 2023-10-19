//
//  FiltersSheetView.swift
//  NewsAPI
//
//  Created by Oleh Oliinykov on 04.10.2023.
//

import SwiftUI

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
    
    @Binding var language: Languages
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
            
            FilterView(selectedFilter: $sortingParameter)
            
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
            
            FilterView(selectedFilter: $language)
            
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
            
            FilterView(selectedFilter: $searchWordIn)

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
            FilterView(selectedFilter: $pageSize)
            
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var fromDatePicker: some View {
        DatePicker(Constants.SectionTitles.fromSection, selection: $startDate, in: ...endDateMinusOne(), displayedComponents: .date)
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

extension FiltersSheetView {
    private func endDateMinusOne() -> Date {
        let daysForSubstract: Int = -1
        guard let minusOneDay = Calendar.current.date(byAdding: .day, value: daysForSubstract, to: endDate) else { return endDate }
        
        
        return minusOneDay
    }
}
