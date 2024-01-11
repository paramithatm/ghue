//
//  SearchUserViewModelTests.swift
//  git-user-explorerTests
//
//  Created by Paramitha on 11/01/24.
//

import Combine
import XCTest
@testable import git_user_explorer

class SearchUserViewModelTests: XCTestCase {
    var viewModel: SearchUserViewModel!
    var mockProvider: MockGitNetworkProvider!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockProvider = MockGitNetworkProvider()
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockProvider = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testSuccessSearchForUser() {
        let expectation = XCTestExpectation(description: "Search user successfully and show list of users")
        
        viewModel = SearchUserViewModel(networkProvider: mockProvider)
        
        // should show initial state when view model first initialized
        XCTAssertEqual(viewModel.viewState, .initialState)
        
        mockProvider.searchUsersResult = { _, _ in Future {
            $0(.success([.validTemplate1, .validTemplate2]))
        } }
        
        viewModel.fetchSearchResult(keyword: "someone")
        
        // view should show loading when searching
        XCTAssertEqual(viewModel.viewState, .loading)

        viewModel.$viewState
            .sink { state in
                if case .showResult = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        // users list should be updated with proper result
        XCTAssertEqual(viewModel.users, [.validTemplate1, .validTemplate2])
        // view should show result
        XCTAssertEqual(viewModel.viewState, .showResult)
    }
    
    func testFailedSearchForUser() {
        let expectation = XCTestExpectation(description: "Search user failed and show error")
        
        viewModel = SearchUserViewModel(networkProvider: mockProvider)
        
        XCTAssertEqual(viewModel.viewState, .initialState)
        
        mockProvider.searchUsersResult = { _, _ in Future {
            $0(.failure(CommonError.serverError))
        } }
        
        viewModel.fetchSearchResult(keyword: "someone")
        
        XCTAssertEqual(viewModel.viewState, .loading)

        viewModel.$viewState
            .sink { state in
                if case .error = state {
                    // fulfill expectation when got result
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        // view should show error
        XCTAssertEqual(viewModel.viewState, .error(CommonError.serverError.localizedDescription))
    }
}
