//
//  CustomViewModifierTest.swift
//  TestingThings
//
//  Created by Greg Ross on 20/08/2022.
//

import SwiftUI



struct CustomViewModifierTest: View {
    
    
    var body: some View {
        VStack{
            Text("HELLO WORLD")
                .withDefaultTextFormatting()
            
            Text("HELLO WORLD")
                .withDefaultTextFormatting()
            
            Text("HELLO WORLD")
                .withDefaultTextFormatting()
        }
    }
}



struct CustomViewModifierTest_Previews: PreviewProvider {
    static var previews: some View {
        CustomViewModifierTest()
    }
}



struct TextModifier: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding()
        
    }
}

extension View{
    func withDefaultTextFormatting() -> some View {
        self
            .modifier(TextModifier())
    }
}
