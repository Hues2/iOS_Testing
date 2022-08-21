//
//  StarRatingMask.swift
//  TestingThings
//
//  Created by Greg Ross on 16/08/2022.
//

import SwiftUI

struct StarRatingMask: View {
    
    @State var isShowingModal: Bool = false
    
    @State var rating: Int = 0
    
    var body: some View {
        
        VStack{
            Button {
                withAnimation(.easeInOut(duration: 0.35)){
                    isShowingModal.toggle()
                }
                
            } label: {
                Text("TOGGLE MODAL")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.teal)
                    )
            }

            
            Spacer()
            
            stars
                .overlay(
                    yellowRectangle.mask(stars)
                )
        }
        .modifier(ModalModifier(isShowingModal: $isShowingModal))
        
        
    }
}



extension StarRatingMask{
    private var stars: some View{
        HStack(spacing: 0){
            ForEach(1..<6){ index in
                Image(systemName: "star.fill")
                    .foregroundColor(.gray)
                    .font(.largeTitle)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)){
                            rating = index
                        }
                    }
            }
        }
    }
    
    
    private var yellowRectangle: some View{
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing)
                    )
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
            
        }
        .allowsHitTesting(false)
        
    }
}







struct StarRatingMask_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingMask()
    }
}



struct ModalModifier: ViewModifier{
    
    @Binding var isShowingModal: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
            content
                .zIndex(0)
            if isShowingModal{
                Modal()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.4)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
            
        }
    }
}


struct Modal: View{
    var body: some View{
        ZStack{
            Color.green
                .ignoresSafeArea()
            
            VStack{
                Text("THE MODAL")
            }
        }
        .cornerRadius(15)
        .ignoresSafeArea()
    }
}
