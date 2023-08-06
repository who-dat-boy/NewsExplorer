//
//  News.swift
//  NewsExplorer
//
//  Created by Arthur ? on 06.08.2023.
//

import Foundation

struct News: Codable {
    let articles: [Article]
}

struct Article: Codable, Hashable {
    let source: Source
    
    let author: String?
    let title: String
    let description: String?

    let sourceUrl: String
    let imageUrl: String?
    let publishedAt: Date
    
    var unwrappedAuthor: String {
        author ?? "No author"
    }
    
    var unwrappedDescription: String {
        description ?? "No description"
    }

    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case sourceUrl = "url"
        case imageUrl = "urlToImage"
        case publishedAt
    }
    
    static let example = Article(
        source: Source(name: "The Verge"),
        author: "Justine Calma",
        title: "Can banks push Bitcoin to clean up its act?",
        description: "Banks and asset managers have a big stake in Bitcoin, so Greenpeace wants them to crack down on the cryptocurrency’s pollution.",
        sourceUrl:  "https://www.theverge.com/2023/7/11/23778688/bitcoin-energy-emissions-climate-change-banks-asset-managers-greenpeace",
        imageUrl: "https://cdn.vox-cdn.com/thumbor/ODx_QBV2qCE_dfhHtwtaZ8W6J8I=/0x0:7144x4743/1200x628/filters:focal(3572x2372:3573x2373)/cdn.vox-cdn.com/uploads/chorus_asset/file/24763884/1235926940.jpg",
        publishedAt: Date()
    )
}

struct Source: Codable, Hashable {
    let name: String
}
