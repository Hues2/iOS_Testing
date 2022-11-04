//
//  AnimatedBorder.swift
//  TestingThings
//
//  Created by Greg Ross on 04/11/2022.
//

import SwiftUI

struct AnimatedBorder: View {
    @State var x: CGFloat = 0
    
      var body: some View {
        Rectangle()
          .strokeBorder(style: .init(lineWidth: 8, dash: [10], dashPhase: x))
          .onAppear { self.x -= 20 }
          .animation(Animation.linear.repeatForever(autoreverses: false))
      }
}

struct AnimatedBorder_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBorder()
    }
}
