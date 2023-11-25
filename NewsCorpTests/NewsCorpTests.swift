//
//  NewsCorpTests.swift
//  NewsCorpTests
//
//  Created by James Kim on 11/25/23.
//

import XCTest
import Combine
@testable import NewsCorp

final class NewsCorpTests: XCTestCase {
    
    var viewModel: PhotoViewerListViewModel!
    private let dummies = [PhotoAsset.dummy(id: 0), PhotoAsset.dummy(id: 1)]
    private var photoListViewCallCount = 0
    
    private var cancellables: [AnyCancellable] = []
    override func setUpWithError() throws {
        let apiService = MockAPIService()
        viewModel = PhotoViewerListViewModel(apiService: apiService)
        
        apiService.stub(for: PhotoListRequest.self, response: { _ in
            self.photoListViewCallCount += 1
            
            return Result.Publisher(self.dummies)
                .eraseToAnyPublisher()
        })
        
        viewModel = PhotoViewerListViewModel(apiService: apiService)
    }

    func test_viewDidOnAppear() throws {
        let previousCount = photoListViewCallCount
        viewModel.inputStream.send(.onAppear)
        
        let viewAppearAlert = XCTestExpectation(description: "check for the view did appear")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertEqual(self.viewModel.assets.count, self.dummies.count)
            viewAppearAlert.fulfill()
        })

        wait(for: [viewAppearAlert], timeout: 1.5)

        XCTAssertEqual(previousCount + 1, photoListViewCallCount)
    }

    func test_userDidPullSCrollView() throws {
        let previousCount = photoListViewCallCount
        viewModel.inputStream.send(.didPullScrollView)
        
        let didPullSCrollAlert = XCTestExpectation(description: "check for when user pulls scrollview")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            XCTAssertEqual(self.viewModel.assets.count, self.dummies.count)
            didPullSCrollAlert.fulfill()
        })

        wait(for: [didPullSCrollAlert], timeout: 1.5)
        
        XCTAssertEqual(previousCount + 1, photoListViewCallCount)
    }

}
