//
//  GenericsTest.swift
//  TestingThings
//
//  Created by Greg Ross on 21/08/2022.
//

import SwiftUI


struct StringModel{
    let info: String?
    
    func removeInfo() -> StringModel{
        return StringModel(info: nil)
    }
}


struct GenericModel <T>{
    let info: T?
    
    func removeInfo() -> GenericModel{
        return GenericModel(info: nil)
    }
}

class GenericsTestViewModel: ObservableObject{
    @Published var stringModel = StringModel(info: "Hello World")
    
    @Published var genericStringModel = GenericModel(info: "This is a Generic Model String")
    @Published var genericBoolModel = GenericModel(info: true)
    
    
    
    func removeData(){
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}



struct GenericView<T: View>: View{
    let content: T
    let title: String
    
    var body: some View{
        VStack{
            Text(title)
            content
        }
    }
}


struct GenericsTest: View {
    @StateObject private var vm = GenericsTestViewModel()
    
    
    
    var body: some View {
        VStack{
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
            GenericView(content: Text("Generic Content"), title: "Hi")
                
        }
        .onTapGesture {
            vm.removeData()
        }
    }
}

struct GenericsTest_Previews: PreviewProvider {
    static var previews: some View {
        GenericsTest()
    }
}
