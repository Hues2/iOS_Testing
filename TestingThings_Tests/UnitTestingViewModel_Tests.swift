//
//  UnitTestingViewModel_Tests.swift
//  TestingThings_Tests
//
//  Created by Greg Ross on 24/08/2022.
//

import XCTest
@testable import TestingThings
import Combine


// Naming structure: test_UnitOfWork_StateUnderTest_ExpectedBehaviour
// Naming structure: test_[struct or class]_[var or function]_[expected result]

// Testing structure: Given, When, Then



class UnitTestingViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestingViewModel?
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = UnitTestingViewModel(isPremium: Bool.random())
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func test_UnitTestViewModel_isPremium_shouldBeTrue(){
        // Given
        let userIsPremium: Bool = true
        
        // When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeFalse(){
        // Given
        let userIsPremium: Bool = false
        
        // When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeInjectedValue(){
        // Given
        let userIsPremium: Bool = Bool.random()
        
        // When
        let vm = UnitTestingViewModel(isPremium: userIsPremium)
        
        // Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestViewModel_isPremium_shouldBeInjectedValue_stress(){
        for _ in 0..<10{
            // Given
            let userIsPremium: Bool = Bool.random()
            
            // When
            let vm = UnitTestingViewModel(isPremium: userIsPremium)
            
            // Then
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
        
    }
    
    func test_UnitTestingViewModel_dataArray_shouldBeEmpty(){
        // Given
        
        // When
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldAddItems(){
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1...100)
        
        for x in 1...loopCount{
            vm.addItem(item: UUID().uuidString) // -> UUID().uuidString always has 36 characters, so i should create a function that returns a random string of random length
            
            // Then
            XCTAssertEqual(vm.dataArray.count, x) // --> At each step of the iteration, there should be x amount of items added to the vm.dataArray
        }
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankItems(){
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertFalse(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
        XCTAssertNotEqual(vm.dataArray.count, 1)
    }
    
    func test_UnitTestingViewModel_dataArray_shouldNotAddBlankItems2(){
        // Given
        guard let vm = viewModel else { XCTFail(); return}
        
        // When
        vm.addItem(item: "")
        
        // Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertFalse(!vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
        XCTAssertNotEqual(vm.dataArray.count, 1)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldStartAsNil(){
        // Given
        
        // When
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // Then
        XCTAssertEqual(vm.selectedItem, nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldNotBeNil_stress(){
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        
        for _ in 0..<loopCount{
            let randomString = UUID().uuidString
            
            // With this, we know that the dataArray will always contain the item that vm.selectItem is checking for
            vm.addItem(item: randomString)
            
            vm.selectItem(item: randomString)
            
            // Then
            XCTAssertEqual(vm.selectedItem, randomString)
            XCTAssertNotEqual(vm.selectedItem, nil)
        }
        
        
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenItemIsNotInTheDataArray_stress(){
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        
        for _ in 0..<loopCount{
            let randomString = UUID().uuidString
            
            vm.selectItem(item: randomString)
            
            // Then
            XCTAssertEqual(vm.selectedItem, nil)
        }
    }
    
    func test_UnitTestingViewModel_selectedItem_shouldBeNilWhenInvalidItemIsSelectedAfterCorrectItemIsSelected_stress(){
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 0..<100)
        
        for _ in 0..<loopCount{
            
            // Adding item to list and then selecting it
            let randomString = UUID().uuidString
            vm.addItem(item: randomString)
            vm.selectItem(item: randomString)
            
            // Selecting item that is not in list
            vm.selectItem(item: UUID().uuidString)
            
            // Then
            XCTAssertEqual(vm.selectedItem, nil)
        }
    }
    
    func test_UnitTestingViewModel_saveitem_shouldThrowItemNotFoundError(){
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
            // Adding items to the data array, incase it affects the .saveItem function tested below
        let loopCount: Int = Int.random(in: 0..<100)
        for _ in 0..<loopCount{
            vm.addItem(item: UUID().uuidString)
        }
            
        // Then
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw item not found error."){ error in // --> Testing to make sure an error is thrown
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.itemNotFound) // --> Testing to see if the thrown error is the correct error
        }
    }
    
    func test_UnitTestingViewModel_saveitem_blankStringShouldThrowNoDataError(){
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
            // Adding items to the data array, incase it affects the .saveItem function tested below
        let loopCount: Int = Int.random(in: 0..<100)
        for _ in 0..<loopCount{
            vm.addItem(item: UUID().uuidString)
        }
            
        // Then
        do {
            try vm.saveItem(item: "")
        } catch {
            let returnedError = error as? UnitTestingViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingViewModel_saveitem_shouldSaveItem(){
        // Given
        let vm = UnitTestingViewModel(isPremium: Bool.random())
        
        // When
            // Adding items to the data array, incase it affects the .saveItem function tested below
        let loopCount: Int = Int.random(in: 0..<100)
        let randomString = UUID().uuidString
        for _ in 0..<loopCount{
            vm.addItem(item: UUID().uuidString)
        }
        vm.addItem(item: randomString)
            
        // Then
        XCTAssertNoThrow(try vm.saveItem(item: randomString))
        do {
            try vm.saveItem(item: randomString)
        } catch {
            XCTFail()
        }
    }
    
    
    //MARK: - Combine Tests
    func test_UnitTestingViewModel_downloadWithEscaping_shouldReturnItems(){
        // Given
        guard let vm = viewModel else {XCTFail(); return}
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after 3 seconds")
        
        vm.$dataArray
            .dropFirst() // --> As it will publish the initial empty value, so we drop it
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithEscaping()
            
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingViewModel_downloadWithCombine_shouldReturnItems(){
        // Given
        guard let vm = viewModel else {XCTFail(); return}
        
        // When
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        vm.$dataArray
            .dropFirst() // --> As it will publish the initial empty value, so we drop it
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithCombine()
            
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    
    
    
}
