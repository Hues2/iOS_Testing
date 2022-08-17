//
//  BackgroundThreadTest.swift
//  TestingThings
//
//  Created by Greg Ross on 17/08/2022.
//

import SwiftUI
 

typealias MyString = String

class BackgroundThreadViewModel: ObservableObject{
    
    @Published var dataArray: [MyString] = []
    
    
    
    func fetchData(){

        DispatchQueue.global(qos: .background).async{ [weak self] in
            guard let newData = self?.downloadData() else {return}
            print("\n CHECK 1 \n")
            print(Thread.isMainThread)
            print(Thread.current)
            
            DispatchQueue.main.async {
                self?.dataArray = newData
                print("\n CHECK 2 \n")
                print(Thread.isMainThread)
                print(Thread.current)
            }
        }
        
        
    }
    
    
   private  func downloadData() -> [String]{
        var data: [String] = []
        
        for x in 0..<100{
            data.append("\(x)")
            print(data)
        }
        
        return data
        
    }
    
}


struct BackgroundThreadTest: View {
    @StateObject var vm = BackgroundThreadViewModel()
    
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 10){
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                ForEach(vm.dataArray, id:\.self){ item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadTest_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadTest()
    }
}
