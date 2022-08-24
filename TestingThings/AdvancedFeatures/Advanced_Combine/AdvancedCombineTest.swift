//
//  AdvancedCombineTest.swift
//  TestingThings
//
//  Created by Greg Ross on 24/08/2022.
//

import SwiftUI
import Combine


class AdvancedCombineDataService{
//    @Published var basicPublisher: String = "First publish"
//    let currentValuePublisher = CurrentValueSubject<Int, Error>("First publish")
    
    /*
        Passthrough works the same as current value publisher, but it does not hold a current value
        Which can make it a bit more memory efficient
        This is used when we don't need to hod the value here, which in this case we don't
        as the value is saved in te view model instead
     */
     
    let passthroughPublisher = PassthroughSubject<Int, Error>()
    
    let boolPublisher = PassthroughSubject<Bool, Error>()
    
    let intPublisher = PassthroughSubject<Int, Error>()

    
    
    init(){
        publishFakeData()
    }
    
    
    private func publishFakeData(){
        
        let items: [Int] = Array(1..<11)
        
        for x in items.indices{
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x)){
//                self.basicPublisher = items[x]
//                self.currentValuePublisher.send(items[x])
                self.passthroughPublisher.send(items[x])
                
                
                if (x > 4 && x < 8){
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else{
                    self.boolPublisher.send(false)
                }
                

                // This is to let the view model know when this publisher has published its last item
                if x == items.indices.last{
                    self.passthroughPublisher.send(completion: .finished)
                }
            }
        }
        
        
        // This is to test the debounce
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0){
//            self.passthroughPublisher.send(1)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
//            self.passthroughPublisher.send(2)
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
//            self.passthroughPublisher.send(3)
//        }
        
        
    }
}


class AdvancedCombineTestViewModel: ObservableObject{
    
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []
    @Published var error: String = ""
    let multicastSubject = PassthroughSubject<Int, Error>()
    
    private let dataService = AdvancedCombineDataService()
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    
    private func addSubscribers(){
//        dataService.$basicPublisher
//        dataService.currentValuePublisher
//        dataService.passthroughPublisher
        
        // MARK: Sequence Operations
        /*
        
        // MARK: .first
            // Returns only the first value that the publisher publishes
//            .first()
            
            // Returns the first value which conforms to the logic
//            .first(where: {$0 > 4})
        
            // This will throw an erro
//            .tryFirst(where: { int in
//                if int == 3{
//                    throw URLError(.badServerResponse)
//                }
//
//                return int > 4
//            })
        
        // MARK: .last
        /*
            When using these .last, the completion in the .sink won't run until the passthrough publisher has sent a completion
            This way the .last knows when it is the last value
         */
//            .last()
//            .last(where: {$0 < 9})
        
        
        // MARK: .dropFirst
        /*
         This drop first can be useful when using the @Published or the CurrentValueSubject, to drop the initial value we give it (if needed)
         */
//            .dropFirst()
//            .dropFirst(3)
        // This drops items until... Once the condition is met it will run, so mainly useful to drop items at start, not end
//            .drop(while: {$0 > 3})
//            .tryDrop(while: { int in
//                if int == 5{
//                    throw URLError(.badServerResponse)
//                }
//                return int < 6
//            })
        
        // MARK: .prefix
//            .prefix(4)
//            .prefix(while: {$0 < 5})
        
        // MARK: .output
            // Returns the item at index 2
//            .output(at: 2)
            // Returns items between specified indexes
//            .output(in: 2..<5)
        
        
        */
        
        // MARK: Mathematic Operations
        
        /*
            // MARK: .max
            // This works as the returned values are integers
            // This would not work if the passthrough subject didnt send a completion
//            .max()
//            .max(by: {$0 < $1})
//            .tryMax(by: )
        
            // MARK: .min
//            .min()
//            .min(by: )
//            .tryMin(by: )
         
         */
        
        // MARK: Map, Filter, Scan, Reduce
        
        /*
         
        
        // MARK: Map
//            .map({String($0)})
        
            // Once it hits 5, the failure is called and nothing else will be printed
//            .tryMap({ int in
//                if int == 5{
//                    throw URLError(.badServerResponse)
//                }
//
//                return String(int)
//            })
        
            // If something doesn't work, it will ignore it, instead of throwing an error
            // When it returns nil, that value will not be used
//            .compactMap({ int in
//                if int == 5{
//                    return nil
//                }
//
//                return String(int)
//            })
        
        
            // If some nils are expected then use compact map, but if an error should be thrown for a specific case and don't want to continue then tryCompactMap can be used
//            .tryCompactMap({ int in
//
//            })
        
        // MARK: Filter
        
//            .filter({$0 > 3})
//            .tryFilter({ int in
//
//            })
        
        
        
        // MARK: .removeDuplicates
            // For this to work it has to be back to back publishes
//            .removeDuplicates()
//            .removeDuplicates(by: { int1, int2 in
//                return int1 == int2
//            })
//            .tryRemoveDuplicates(by: )
        
        // MARK: .replaceNil
            // Can only be used if the publisher publishes optional types
//            .replaceNil(with: )
        
            // For example, when publishing arrays, if the array is empty, then replace it with a default value
//            .replaceEmpty(with: )
        
//            .replaceError(with: )
        
        // MARK: .scan
            // Gets all previously published values and logic can be done with those values and the new value
//            .scan(0, { existingValue, newValue in
//                return existingValue + newValue
//            })
//            .scan(0, {$0 + $1})
//            .scan(0, +)
//            .tryScan(0, )
        
        // MARK: .reduce
            // This does the same as scan, but only return the last value
//            .reduce(0, { existingValue, newValue in
//                return existingValue + newValue
//            })
//            .reduce(0, +)
        
        
        // MARK: .collect
            // This will collect all of the publishes and return them all at once
        
//            .map({String($0)})
//            .collect()
            // Collects in batches of 3
//            .collect(3)
            
        // MARK: .allSatisfy
            // Reeturns a bool if all the values satisfy a certain condition, and it returns only if the publisher sends a completion
//            .allSatisfy({$0 == 5})
//            .allSatisfy({$0 < 50})
        
        
        */
        
        
        // MARK: Timing Operations
        /*
        
            // MARK: .debounce
            // It publishes the value if there is at least 1 second between each publish
            // This is good for textfields, as you don't want to publish every change for every single letter
//            .debounce(for: 0.5, scheduler: DispatchQueue.main)
        
            // MARK: .delay
//            .delay(for: 2, scheduler: DispatchQueue.main)
        
            // MARK: .measureInterval
            // This could be good for debugging purposes
//            .measureInterval(using: DispatchQueue.main)
//            .map({stride in
//                return "\(stride.timeInterval)"
//            })
        
        
            // MARK: .throttle
            // Could be useful to reload data every 5 seconds or minutes or hours....
//            .throttle(for: 5, scheduler: DispatchQueue.main, latest: true)
        
            // MARK: .retry
            // If an error is thrown, isntead of going to the failure completion, retry instead
//            .retry(2)
        
            // MARK: .timeout
            // If there is no publish within 0.75 seconds (in this case), then this terminates the publisher
            // This could be good for API calls, maybe after 10 seconds, if the data has not been returned, then terminate it
            
            .timeout(0.75, scheduler: DispatchQueue.main)
         
         */
        
        // MARK: Multiple Publishers & Subscribers
        
        /*
         
        
            // MARK: .combineLatest
//            .combineLatest(dataService.boolPublisher, dataService.intPublisher)
        
//            .compactMap({ (int, bool) in
//                if bool {
//                    return String(int)
//                } else {
//                    return nil
//                }
//            })
//            .compactMap({$1 ? String($0) : "n/a"})
            // Remove duplicates is called here as this code runs whenever either one of the publishers changes
//            .removeDuplicates()
        
        
            // This only runs when all 3 of the publishers have at least 1 va;ue to publish
            // Since the intPublisher only publishes a value when (x > 4 && x < 8) then all of this code
            // only runs when that intpublisher has published at least once
        
            // If this code always has to run as long as one publisher publishes a new value, then use Current Value Subject or @Published, as they ensure that the publisher always has an initial value
        
//            .compactMap({ (int1, bool, int2) in
//                if bool{
//                    return String(int1)
//                } else{
//                    return "n/a"
//                }
//            })
        
        
        
            // MARK: .merge
            // Merge 2 publishers. Both publishers need to emit the same value type
//            .merge(with: dataService.intPublisher)
        
        
            // MARK: .zip
            // This zips up publishers into a tuple
//            .zip(dataService.boolPublisher, dataService.intPublisher)
        
            // It can only create the tuple when all three publishers have a value
            // When using the intPublisher in the zip, it doesn't always have a value
        
//            .map({tuple in
//                return String(tuple.0) + tuple.1.description + String(tuple.2)
//            })
        
        
            // MARK: .catch
            // Catch an error and return a publisher
//            .catch({ error in
//                return self.dataService.intPublisher
//            })
        
        */
        
        
        // MARK: .share
        // Common manipulation can be done here before sharing it with the different subscribers
        let sharedPublisher = dataService.passthroughPublisher
//            .dropFirst(3)
            .share()
        // MARK: multicast
            // This multicast stores the publish in a different publisher and then we can determinewhen we want it to connect to the subscribers
            // When doing a multicast we need co connnect to it
//            .multicast {
//                PassthroughSubject<Int, Error>()
//            }
            .multicast(subject: multicastSubject)
        

        sharedPublisher
            .map({String($0)})
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                // This one is use for the .collect, as it returns all of the publishes as a list
//                self?.data = returnedValue
                // This one is used for the collect(3)
//                self?.data.append(contentsOf: returnedValue)
                
                self?.data.append(returnedValue)
            }
            .store(in: &cancellables)

        
        
        
        sharedPublisher
            .map({$0 > 5 ? true : false})
            .sink { completion in
                switch completion{
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] returnedValue in
                // This one is use for the .collect, as it returns all of the publishes as a list
//                self?.data = returnedValue
                // This one is used for the collect(3)
//                self?.data.append(contentsOf: returnedValue)
                
                self?.dataBools.append(returnedValue)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            sharedPublisher
                .connect()
                .store(in: &self.cancellables)
        }

        
    }
    
    
}


struct AdvancedCombineTest: View {

    @StateObject private var vm = AdvancedCombineTestViewModel()

    
    var body: some View {
        ScrollView{
            HStack{
                VStack{
                    ForEach(vm.data, id:\.self){
                        Text($0)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    if !vm.error.isEmpty{
                        Text(vm.error)
                    }
                }
                
                VStack{
                    ForEach(vm.dataBools, id:\.self){
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    if !vm.error.isEmpty{
                        Text(vm.error)
                    }
                }
            }
            
        }
    }
}

struct AdvancedCombineTest_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineTest()
    }
}
