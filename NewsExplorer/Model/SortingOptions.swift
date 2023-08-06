//
//  SortingOptions.swift
//  NewsExplorer
//
//  Created by Arthur ? on 06.08.2023.
//

import Foundation

enum SortingOption: String, CaseIterable {
    case author = "Author"
    case title = "Title"
    case description = "Description"
    case publishedAt = "Publish Date"
    case none = "None"
}
