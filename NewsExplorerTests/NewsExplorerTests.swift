//
//  NewsExplorerTests.swift
//  NewsExplorerTests
//
//  Created by Arthur ? on 06.08.2023.
//

import XCTest
@testable import NewsExplorer

final class NewsExplorerTests: XCTestCase {
    func testFetchedJSONMatchesModel() {
        // given
        let bundle = Bundle(for: type(of: self))
        
        guard let urlPath = bundle.url(forResource: "FetchExample", withExtension: "json") else {
            XCTFail("Missing file: FetchExample.json")
            return
        }
        guard let data = try? Data(contentsOf: urlPath) else { XCTFail("Failed to get data"); return }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        // when
        let response = try? decoder.decode(News.self, from: data)
        
        // then
        XCTAssertNotNil(response?.articles)
    }
}
