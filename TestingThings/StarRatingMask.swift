//
//  StarRatingMask.swift
//  TestingThings
//
//  Created by Greg Ross on 16/08/2022.
//

import SwiftUI

struct StarRatingMask: View {
    
    @State var rating: Int = 0
    
    var body: some View {
        
        stars
            .overlay(
                yellowRectangle.mask(stars)
            )
        
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
