//
//  ContentView.swift
//  NewsExplorer
//
//  Created by Arthur ? on 06.08.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NewsViewModel()
    
    @State private var sortingOption: SortingOption = .none
    @State private var searchText: String = ""
    
    @State private var showingDateSelectionSheet: Bool = false
    @State private var isTimeIntervalSet: Bool = false
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.news.isEmpty {
                    if isTimeIntervalSet {
                        Text("No articles in selected time interval.")
                    } else {
                        ProgressView()
                    }
                } else {
                    List(viewModel.getSortedNews(for: sortingOption, with: searchText.lowercased()), id: \.self) { article in
                        NavigationLink {
                            ArticleDetailView(article: article)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(article.title)
                                    .lineLimit(1)
                                    .font(.headline)
                                
                                Text(article.unwrappedDescription)
                                    .lineLimit(3)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .task {
                if viewModel.news.isEmpty {
                    await viewModel.fetchNews()
                }
            }
            .onChange(of: viewModel.url) { _ in
                Task {
                    sortingOption = .none
                    await viewModel.fetchNews()
                }
            }
            .navigationTitle("News Explorer")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // search articles for some time period
                    Button("Set time period") {
                        showingDateSelectionSheet = true
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    // sort articles by available params
                    Menu {
                        ForEach(SortingOption.allCases, id: \.self) { option in
                            Button {
                                sortingOption = option
                            } label: {
                                if option == sortingOption {
                                    Label(option.rawValue, systemImage: "checkmark")
                                } else {
                                    Text(option.rawValue)
                                }
                            }
                        }
                    } label: {
                        Text("Sort by")
                    }
                }
            }
            .sheet(isPresented: $showingDateSelectionSheet) {
                DateSelectionView(viewModel: viewModel, isTimeIntervalSet: $isTimeIntervalSet)
            }
            .searchable(text: $searchText)
            .autocorrectionDisabled()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
