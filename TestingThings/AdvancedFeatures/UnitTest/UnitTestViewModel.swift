//
//  UnitTestViewModel.swift
//  TestingThings
//
//  Created by Greg Ross on 24/08/2022.
//

import Foundation
import SwiftUI
import Combine


class UnitTestingViewModel: ObservableObject{
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    let dataService: NewDataServiceProtocol
    
    
    var cancellables = Set<AnyCancellable>()
    
    // The data service would be passed in through dependency injection, however, for now we give it a default value
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)){
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    
    func addItem(item: String){
        guard !item.isEmpty else {return}
        
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let itemInDataArray = dataArray.first(where: {$0 == item}){
            self.selectedItem = itemInDataArray
        } else{
            self.selectedItem = nil
        }
    }
    
    
    func saveItem(item: String) throws{
        guard !item.isEmpty else{
            throw DataError.noData
        }
        
        if let itemInDataArray = dataArray.first(where: {$0 == item}){
            print("Save item here!!! \(itemInDataArray)")
        } else{
            throw DataError.itemNotFound
        }
    }
    
    
    enum DataError: LocalizedError{
        case noData
        case itemNotFound
    }
    
    
    func downloadWithEscaping(){
        dataService.downloadItemsWithEscaping { [weak self] items in
            self?.dataArray = items
        }
    }
    
    func downloadWithCombine(){
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancellables)

    }
    
}
