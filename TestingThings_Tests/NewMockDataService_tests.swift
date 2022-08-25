//
//  NewMockDataService_tests.swift
//  TestingThings_Tests
//
//  Created by Greg Ross on 24/08/2022.
//

import XCTest
@testable import TestingThings
import Combine

class NewMockDataService_tests: XCTestCase {
    
    
    var cancellables = Set<AnyCancellable>()
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    
    func test_NewMockDataService_init_setValuesCorrectly(){
        // give
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        
        // when
        let dataService = NewMockDataService(items: items)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        // then
        XCTAssertTrue(!dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
   
    
    func test_NewMockDataService_init_downloadItemsWithEscaping(){
        // give
        let dataService = NewMockDataService(items: nil)
        
        // when
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(dataService.items, items)
        
        
    }
    
    
    func test_NewMockDataService_init_downloadItemsWithCombine(){
        // give
        let dataService = NewMockDataService(items: nil)
        
        // when
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion{
                case .finished:
                    expectation.fulfill()
                    break
                case .failure(let error):
                    print("\n \(error) \n")
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
                
            }
            .store(in: &cancellables)

        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(dataService.items, items)
        
        
    }
    
    func test_NewMockDataService_init_downloadItemsWithCombine_doesFail(){
        // give
        let dataService = NewMockDataService(items: [])
        
        // when
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw a URLError.badServerResponse")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion{
                case .finished:
                    // If it reaches here, the test should fail
                    XCTFail()
                    break
                case .failure(let error):
                    print("\n \(error) \n")
                    expectation.fulfill()
                    
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if urlError == URLError(.badServerResponse){
                        expectation2.fulfill()
                    }
                    
                }
            } receiveValue: { returnedItems in
                items = returnedItems
                
            }
            .store(in: &cancellables)

        
        // then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(dataService.items.count, items.count)
        
        
    }

}
