//
//  AnyTransitionTest.swift
//  TestingThings
//
//  Created by Greg Ross on 21/08/2022.
//

import SwiftUI


// Create my own view modifier (this is what will be animated with the transition)
struct RotateViewModifier: ViewModifier{
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                    y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}


struct RotateFade: ViewModifier{

    let rotation: Double
    
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .opacity(rotation == 0 ? 1 : 0.1)
            .scaleEffect(rotation == 0 ? 1 : 0.0)
    }
}


extension AnyTransition{
    
    static var rotating: AnyTransition{
        return AnyTransition
                    .modifier(active: RotateViewModifier(rotation: 180),
                                      identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotating(rotation: Double) -> AnyTransition{
        modifier(active: RotateViewModifier(rotation: rotation),
                                      identity: RotateViewModifier(rotation: 0))
    }
    
    
    static var rotatingOn: AnyTransition{
        asymmetric(insertion: .rotating,
                   removal: .move(edge: .leading))
    }
    
    
    static var rotateFadeIn: AnyTransition{
        modifier(active: RotateFade(rotation: 180), identity: RotateFade(rotation: 0))
    }
    
    
    
}


struct AnyTransitionTest: View {
    @State private var showRectangle: Bool = false
    
    
    var body: some View {
        VStack{
            Spacer()
            
            if showRectangle{
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350, alignment: .center)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .modifier(RotateViewModifier())
//                    .transition(AnyTransition.rotating.animation(.easeInOut))
//                    .transition(.rotating(rotation: 360))
//                    .transition(.rotatingOn)
                    .transition(.rotateFadeIn)
            }
            
            
            Spacer()
            
            Text("CLICK ME!")
                .fontWeight(.heavy)
                .withDefaultTextFormatting()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)){
                        showRectangle.toggle()
                    }
                }
        }
    }
}

struct AnyTransitionTest_Previews: PreviewProvider {
    static var previews: some View {
        AnyTransitionTest()
    }
}
