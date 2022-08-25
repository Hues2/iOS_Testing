//
//  FuturePromiseTest.swift
//  TestingThings
//
//  Created by Greg Ross on 25/08/2022.
//

import SwiftUI
import Combine


class FuturePromiseViewModel: ObservableObject{
    
    @Published var title: String = "Starting Title"
    let url = URL(string: "https://www.google.co.uk")!
    
    var cancellables = Set<AnyCancellable>()
    
    init(){
        download()
    }
    
    
    func download(){
//        getCombinePublisher()
        getFuturePublisher()
            .sink { _ in

            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)
        
        
        
//        getEscapingClosure { [weak self] (value, error) in
//            self?.title = value
//        }
        
        

    }
    
    
    func getCombinePublisher() -> AnyPublisher<String, URLError>{
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({_ in
                return "New Value"
            })
            .eraseToAnyPublisher()
    }
    
    
    func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> ()){
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            completionHandler("New Value 2", nil)
        }
        .resume()
    }
    
    
    func getFuturePublisher() -> Future<String, Error> {
        return Future { promise in
            self.getEscapingClosure {(returnedValue, error) in
                if let error = error {
                    promise(.failure(error))
                } else{
                    promise(.success(returnedValue))
                }
            }
        }
    }
    
    
    func doSomething(completionHandler: @escaping (_ value: String) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completionHandler("New String")
        }
    }
    
    
    func doSomethingInTheFuture() -> Future<String, Error>{
        return Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
    
}


struct FuturePromiseTest: View {
    
    @StateObject private var vm = FuturePromiseViewModel()
    
    var body: some View {
        Text(vm.title)
    }
}

struct FuturePromiseTest_Previews: PreviewProvider {
    static var previews: some View {
        FuturePromiseTest()
    }
}
