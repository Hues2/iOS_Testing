//
//  StarRatingMask.swift
//  TestingThings
//
//  Created by Greg Ross on 16/08/2022.
//

import SwiftUI


class MyClass: ObservableObject{
    
//    var A = [1, 3, 6, 4, 1, 2]
    
//    public func solution(_ S : inout String) -> Bool {
//        // write your code in Swift 4.2.1 (Linux)
//
//        guard let firstLetter = S.first else { return false}
//
//        // If there is no letter a, return true
//        // if there is no letter b, return true
//        if !S.contains("a") || !S.contains("b"){
//            return true
//        }
//
//
//        // if it cotains both letter and the first letter is b, return false
//        if firstLetter == "b"{
//                return false
//        }
//
//
//        // Get the first index of a letter "b", make a substring from that index
//        // If that substring contains "a" then return false
//
//        guard let firstIndexOfB = S.firstIndex(of: "b") else { return false }
//
//        let substring = S.substring(from: firstIndexOfB)
//
//        return !substring.contains("a")
//
//
//
//    }
    

    
    
//    public func solution(_ A : inout [Int], _ B : inout [Int], _ X : Int, _ Y : Int) -> Int {
//        // write your code in Swift 4.2.1 (Linux)
//
//        let circle = 20
//
//        // Check for valid X
//        // keep track of the valid indexes, as these indexes will match the Y indexes
//        var validXIndexes = [Int]()
//        for (index, xCoord) in A.enumerated(){
//
//            let absoluteDistance = abs(xCoord - X)
//
//            if absoluteDistance <= circle{
//                validXIndexes.append(index)
//            }
//        }
//
//        // Now check to see if the corresponding Y values at those indexes are also valid
//        var validYIndexes = [Int]()
//        for (index, yCoord) in B.enumerated(){
//
//            if validXIndexes.contains(index){
//
//                // This y coordinate is related to a valid x coordinate
//                let absoluteDistance = abs(yCoord - Y)
//
//                if absoluteDistance <= circle{
//                    // It is within the correct distance
//                    validYIndexes.append(index)
//                }
//            }
//        }
//
//        // If the valid Y indexes is empty, then return 0
//        // If there are valid Y indexes, then we return the first one (Task doesn't specify what to return if there are multiple)
//        return validYIndexes.isEmpty ? -1 : (validYIndexes.first ?? -1)
//
//    }
    
    
    
//        public func solution(_ A : Int, _ B : Int) -> Int {
//            // write your code in Swift 4.2.1 (Linux)
//    
//            let totalAvailable: Int = A + B
//            let numberOfSides: Int = 4
//            var ideal: Int = Int(totalAvailable / numberOfSides)
//            
//            // If it is less
//            if ideal < 1{
//                return 0
//            }
//            
//            
//            var canMakeSquare: Bool = true
//            
//            while canMakeSquare{
//                let numberOfPossibleSticksFromA: Int = A / ideal
//                let numberOfPossibleSticksFromB: Int = B / ideal
//                if numberOfPossibleSticksFromA + numberOfPossibleSticksFromB >= numberOfSides{
//                    canMakeSquare = false
//                }
//                
//                ideal -= 1
//                
//                if ideal == 0{
//                    canMakeSquare = false
//                }
//                
//            }
//
//            return ideal + 1
//        }
    
    
    
    init(){
        
//        var A = 10
//        var B = 21
//        var A = 13
//        var B = 11
//        print("\n \(solution(A, B)) \n")
        
        

//        var a = 10
//        var b = 21
//        print("\n \(solution(a, b)) \n")
        
//        var A = [100, 200, 100]
//        var B = [50, 100, 100]
//        var X = 100
//        var Y = 100
        
//        var A = [100, 200, 100]
//        var B = [50, 100, 100]
//        var X = 100
//        var Y = 70
        
//        var A = [100, 200, 100]
//        var B = [50, 100, 100]
//        var X = 200
//        var Y = 60
//
//        print("\n \(solution(&A, &B, X, Y)) \n")
    }
}

struct StarRatingMask: View {
    
    @StateObject var myClass = MyClass()
    
    
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
