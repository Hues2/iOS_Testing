//
//  CustomButtonStyleTest.swift
//  TestingThings
//
//  Created by Greg Ross on 20/08/2022.
//

import SwiftUI


struct PressableButtonStyle: ButtonStyle{
    
    let scaleAmount: CGFloat
    
    init(scaleAmount: CGFloat = 0.95){
        self.scaleAmount = scaleAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1)
//            .brightness(configuration.isPressed ? 0.75 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
    }
}


extension View{
    func withPressableStyle() -> some View{
        self.buttonStyle(PressableButtonStyle())
    }
}


struct CustomButtonStyleTest: View {
    
    
    var body: some View {
        Button {
            
        } label: {
            Text("CLICK ME")
                .withDefaultTextFormatting()
        }
        .padding(40)
        .withPressableStyle()

    }
}

struct CustomButtonStyleTest_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonStyleTest()
    }
}
