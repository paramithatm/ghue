//
//  UserDetailsViewModelTests.swift
//  git-user-explorerTests
//
//  Created by Paramitha on 11/01/24.
//

import Combine
import XCTest
@testable import git_user_explorer

class UserDetailsViewModelTests: XCTestCase {
    var viewModel: UserDetailsViewModel!
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
    
    func testSuccessLoadValidData() {
        let expectation = XCTestExpectation(description: "Fetch user details with valid template successfully")
        
        viewModel = UserDetailsViewModel(id: "someone", networkProvider: mockProvider)
        
        // should show initial state when view model first initialized
        XCTAssertEqual(viewModel.viewState, .initialState)
        
        mockProvider.getUserDetailsResult = { _ in Future {
            $0(.success(.validTemplate))
        } }
        
        viewModel.fetchUserDetails()
        
        // view should load when fetching user details
        XCTAssertEqual(viewModel.viewState, .loading)

        viewModel.$viewState
            .sink { state in
                if case .showResult(_) = state {
                    // fulfill expectation when got result
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.viewState, .showResult(.validTemplate))
    }

    func testFailedLoad() {
        let expectation = XCTestExpectation(description: "Fetch user details failed and show error")
        
        viewModel = UserDetailsViewModel(id: "", networkProvider: mockProvider)
        
        mockProvider.getUserDetailsResult = { _ in Future {
            $0(.failure(CommonError.serverError))
        } }
        
        viewModel.fetchUserDetails()
        
        XCTAssertEqual(viewModel.viewState, .loading)

        viewModel.$viewState
            .sink { state in
                if case .error(_) = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.viewState, .error(CommonError.serverError.localizedDescription))
    }
}
