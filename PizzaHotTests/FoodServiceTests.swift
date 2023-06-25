//
//  FoodServiceTests.swift
//  PizzaHotTests
//
//  Created by Dima Zhiltsov on 25.06.2023.
//

import XCTest
@testable import PizzaHot

final class FoodServiceTests: XCTestCase {
    
    var sut: FoodServiceProtocol!
    var networkManager: NetworkManagerMock!
    
    override func setUpWithError() throws {
        networkManager = NetworkManagerMock()
        sut = FoodService(networkManager)
    }
    
    override func tearDownWithError() throws {
        networkManager = nil
        sut = nil
    }
}

// MARK: - GetFoodData Tests

extension FoodServiceTests {

    func testGetFood_Successful() throws {
        // Given
        let expectedResult = [
            FoodData(name: "name", category: "category", description: "description", price: 10, imageUrl: "imageUrl"),
            FoodData(name: "name2", category: "category2", description: "description2", price: 10, imageUrl: "imageUrl2"),
            FoodData(name: "name3", category: "category3", description: "description3", price: 10, imageUrl: "imageUrl3")
        ]
        
        networkManager.expectedResult = .success(expectedResult)
        let expectation = XCTestExpectation(description: "Fetch food data")
        
        // When
        sut.getFoodData { result in
            // Then
            switch result {
            case .success(let foodData):
                XCTAssertEqual(foodData, expectedResult, "Returned food data should match the expected result")
                expectation.fulfill()
            case .failure:
                XCTFail("Should not fail")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetFood_Failure() throws {
        // Given
        let expectedError = NetworkError.failed
        networkManager.expectedResult = .failure(expectedError)
        let expectation = XCTestExpectation(description: "Get an error")
        
        // When
        sut.getFoodData { result in
            // Then
            switch result {
            case .success:
                XCTFail("Should not succeed")
            case .failure(let netError as NetworkError):
                XCTAssertEqual(netError, expectedError, "Incorrect error")
                expectation.fulfill()
            case .failure(_):
                XCTFail("Should be NetworkError")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// MARK: - GetImage Tests

extension FoodServiceTests {
    
    func testGetImage_Successful() throws {
        // Given
        let urlString = "http://mock.com/image.jpg"
        let expectedImage = R.Images.banner1
        guard let expectedImageData = expectedImage.jpegData(compressionQuality: 1.0) else { return }
        
        networkManager.expextedDataResult = .success(expectedImageData)
        let expectation = XCTestExpectation(description: "Fetch an image")
        
        // When
        sut.getImage(urlString: urlString) { result in
            // Then
            switch result {
            case .success(let image):
                guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                    XCTFail("Failed to create image from data")
                    return
                }
                XCTAssertEqual(imageData.count, expectedImageData.count, accuracy: 100, "Incorrect image")
                expectation.fulfill()
            case .failure:
                XCTFail("Should not fail")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetImage_Failure() throws {
        // Given
        let urlString = "invalid-url"
        let expectedError = NetworkError.failed
        networkManager.expextedDataResult = .failure(expectedError)
        let expectation = XCTestExpectation(description: "Get an error")
        
        // When
        sut.getImage(urlString: urlString) { result in
            // Then
            switch result {
            case .success:
                XCTFail("Should not succeed")
            case .failure(let netError as NetworkError):
                XCTAssertEqual(netError, expectedError, "Incorrect error")
                expectation.fulfill()
            case .failure(_):
                XCTFail("Should be Network Error")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
