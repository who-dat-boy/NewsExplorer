//
//  NewsViewModel.swift
//  NewsExplorer
//
//  Created by Arthur ? on 06.08.2023.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var url = URL(string: "https://newsapi.org/v2/everything?q=kanye%20west&apiKey=6f69beda71054145b5d7fc6ca2cf3934")
    
    @Published var news: [Article] = []
    
    var storedSortingOption: SortingOption = .none
    var storedSortedNews: [Article] = []
    
    private let sortByAuthor = { (lhs: Article, rhs: Article) -> Bool in
        return lhs.unwrappedAuthor < rhs.unwrappedAuthor
    }
    
    private let sortByTitle = { (lhs: Article, rhs: Article) -> Bool in
        return lhs.title < rhs.title
    }
    
    private let sortByDescription = { (lhs: Article, rhs: Article) -> Bool in
        return lhs.unwrappedDescription < rhs.unwrappedDescription
    }
    
    private let sortByPublishDate = { (lhs: Article, rhs: Article) -> Bool in
        return lhs.publishedAt > rhs.publishedAt
    }
    
    init() {
        
    }
    
    func fetchNews() async {
        guard let url = url else { print("Invalid URL"); return }
        
        do {
            let (newsData, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let response = try? decoder.decode(News.self, from: newsData) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.news = response.articles
                    self.storedSortedNews = response.articles
                }
            } else {
                print("Failed to decode news data.")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getSortedNews(for sortingOption: SortingOption, with searchText: String) -> [Article] {
        if sortingOption != storedSortingOption {
            storedSortingOption = sortingOption
            storedSortedNews = news.sorted(by: getSortingRule(for: sortingOption))
        }

        if searchText.isEmpty {
            return storedSortedNews
        } else {
            return storedSortedNews.filter {
                $0.title.lowercased().contains(searchText) || $0.unwrappedDescription.lowercased().contains(searchText)
            }
        }
    }
    
    private func getSortingRule(for sortingOption: SortingOption) -> ((Article, Article) -> Bool) {
        switch sortingOption {
        case .author:
            return sortByAuthor
        case .title:
            return sortByTitle
        case .description:
            return sortByDescription
        case .publishedAt:
            return sortByPublishDate
        case .none:
            return { (_, _) in return true }
        }
    }
}
