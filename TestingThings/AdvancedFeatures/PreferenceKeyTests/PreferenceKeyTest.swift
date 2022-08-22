//
//  PreferenceKeyTest.swift
//  TestingThings
//
//  Created by Greg Ross on 22/08/2022.
//

import SwiftUI



struct PreferenceKeyTest: View {
    
    @State private var text: String = "Hello World."
    
    var body: some View {
        NavigationView{
            VStack{
                SecondaryScreen(text: text)
            }
            .navigationTitle("Navigation Title")
            .customTitle("NEW TITLE!!!")
//            .preference(key: CustomTitlePreferenceKey.self, value: "NEW VALUE")
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
            self.text = value
        }
        
    }
}



extension View{
    
    func customTitle(_ text: String) -> some View{
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
    
}



struct PreferenceKeyTest_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyTest()
    }
}



struct SecondaryScreen: View{
    
    let text: String
    @State private var newValue: String = ""
    
    var body: some View{
        Text(text)
            .onAppear{
                getDataFromDatabase()
            }
            .customTitle(newValue)
    }
    
    
    func getDataFromDatabase(){
        //fake download
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.newValue = "NEW VALUE FROM DATABASE"
        }
    }
}


struct CustomTitlePreferenceKey: PreferenceKey{
    
    static var defaultValue: String = ""
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
