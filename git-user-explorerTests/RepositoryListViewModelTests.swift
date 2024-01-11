//
//  RepositoryListViewModelTests.swift
//  git-user-explorerTests
//
//  Created by Paramitha on 11/01/24.
//

import Combine
import XCTest
@testable import git_user_explorer

class RepositoryListViewModelTests: XCTestCase {
    var viewModel: RepositoryListViewModel!
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
        let expectation = XCTestExpectation(description: "Fetch repository list with valid template successfully")
        let mockResponse: [RepoBasicModel] = [.validTemplate, .noDescriptionTemplate, .noLanguageTemplate]
        
        viewModel = RepositoryListViewModel(id: "someone", networkProvider: mockProvider)
        
        XCTAssertEqual(viewModel.viewState, .initialState)
        
        mockProvider.getRepoListResult = { _, _ in Future {
            $0(.success(mockResponse))
        } }
        
        viewModel.fetchRepositoryList()
        
        XCTAssertEqual(viewModel.viewState, .loading)

        viewModel.$viewState
            .sink { state in
                if state == .showResult {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.repos, mockResponse)
        XCTAssertEqual(viewModel.viewState, .showResult)
    }

    func testFailedLoad() {
        let expectation = XCTestExpectation(description: "Fetch repository list failed and show error")
        
        viewModel = RepositoryListViewModel(id: "someone", networkProvider: mockProvider)
        
        XCTAssertEqual(viewModel.viewState, .initialState)
        
        mockProvider.getRepoListResult = { _, _ in Future {
            $0(.failure(CommonError.serverError))
        } }
        
        viewModel.fetchRepositoryList()
        
        XCTAssertEqual(viewModel.viewState, .loading)

        viewModel.$viewState
            .sink { state in
                if case .error = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.viewState, .error(CommonError.serverError.localizedDescription))
    }
}
