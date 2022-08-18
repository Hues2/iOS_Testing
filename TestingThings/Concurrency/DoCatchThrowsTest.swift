//
//  DoCatchThrowsTest.swift
//  TestingThings
//
//  Created by Greg Ross on 17/08/2022.
//

import SwiftUI



class DoCatchThrowsDataService{
    
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?){
        if isActive{
            return ("NEW TEXT!", nil)
        } else{
            return (nil, URLError(.badURL))
        }
    }
    
    
    func getTitle2() -> Result<String, Error>{
        if isActive{
            return .success("NEW TEST 2!")
        } else{
            return .failure(URLError(.badServerResponse))
        }
    }
    
    
    func getTitle3() throws -> String {
//        if isActive{
//            return "NEW TEXT!"
//        } else{
            throw URLError(.badServerResponse)
//        }
    }
    
    
    func getTite4() throws -> String{
        if isActive{
            return "FINAL TEXT!"
        } else{
            throw URLError(.badServerResponse)
        }
    }


class DoCatchThrowsViewModel: ObservableObject{
    @Published var text = "Starting Text"
    
    private let dataService = DoCatchThrowsDataService()
    
    func fetchTitle(){
        
//        let newTitle = try? dataService.getTitle3()
//        if let newTitle = newTitle{
//            self.text = newTitle
//        }
        
        do {
            //try? will not throw an error
            let newTitle = try? dataService.getTitle3()
            if let newTitle = newTitle{
                self.text = newTitle
            }
            
            
            
            let newTitle4 = try dataService.getTite4()
            self.text = newTitle4


        } catch {
            self.text = error.localizedDescription
        }
        
//        let result = dataService.getTitle2()
//
//        switch result{
//        case .success(let title):
//            self.text = title
//        case .failure(let error):
//            self.text = error.localizedDescription
//        }
        
        
//        let returnedResponse = dataService.getTitle()
//        if let newTitle = returnedResponse.title{
//            self.text = newTitle
//        }else if let error = returnedResponse.error{
//            self.text = error.localizedDescription
//        }
        
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
}
