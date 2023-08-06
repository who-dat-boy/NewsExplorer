//
//  AsyncNewsExplorerTests.swift
//  AsyncNewsExplorerTests
//
//  Created by Arthur ? on 06.08.2023.
//

import XCTest
@testable import NewsExplorer

final class AsyncNewsExplorerTests: XCTestCase {
    func testNewsUrlReturnsData() {
        // given
        let viewModel = NewsViewModel()
        let expectation = XCTestExpectation(description: "Fetching news data.")
        
        // when
        let request = URLRequest(url: viewModel.url!)
        URLSession.shared.dataTask(with: request) { data, _, error in
            XCTAssertNotEqual(data, Data())
            expectation.fulfill()
        }.resume()
        
        // then
        wait(for: [expectation], timeout: 5)
    }
}
