//
//  UserViewModelTests.swift
//  RxSwiftExampleTests
//
//  Created by Ahmet Ertas on 23.06.2022.
//

import XCTest
@testable import RxSwiftExample

class UserViewModelTests: XCTestCase {

    private var networkManager: MockNetworkManager!
    private var viewModelToTest: IUserViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        networkManager = MockNetworkManager()
        viewModelToTest = UserViewModel(networkManager: networkManager)
    }

    func testGetUsersEmpty() {
        
        // Arrange
        let usersToTest: [User] = []
        let expectation = XCTestExpectation(description: "Should get empty state")
        
        // Act
        viewModelToTest.usersModelObservable.subscribe(onNext: { users in
            XCTAssertTrue(users == [])
            expectation.fulfill()
        })
        
        networkManager.allUsersResponse = Result.success(usersToTest)
        viewModelToTest.getUsers()
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testGetUsersError() {
        let errorToTest = APIError.badRequest
        let expectation = XCTestExpectation(description: "Should get error state")
        
        // Act
        viewModelToTest.isAnyErrorObservable.subscribe (onNext: { isError in
            XCTAssertTrue(isError)
            expectation.fulfill()
        })
       
        networkManager.allUsersResponse = Result.failure(errorToTest)
        viewModelToTest.getUsers()
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        
        
    }

}


