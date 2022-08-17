//
//  DoCatchThrowsTest.swift
//  TestingThings
//
//  Created by Greg Ross on 17/08/2022.
//

import SwiftUI



class DoCatchThrowsDataManager{
    func getTitle() -> String{
        return "NEW TEXT!"
    }
}


class DoCatchThrowsViewModel: ObservableObject{
    @Published var text = "Starting Text"
    
    private let manager = DoCatchThrowsDataManager()
    
    func fetchTitle(){
        
    }
}

struct DoCatchThrowsTest: View {
    @StateObject var viewModel = DoCatchThrowsViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(
                Color.blue
            )
            .onTapGesture {
                viewModel.fetchTitle()
            }
    }
}

struct DoCatchThrowsTest_Previews: PreviewProvider {
    static var previews: some View {
        DoCatchThrowsTest()
    }
}
