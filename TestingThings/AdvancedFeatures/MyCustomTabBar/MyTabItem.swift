//
//  MyTabItem.swift
//  TestingThings
//
//  Created by Greg Ross on 23/08/2022.
//

import Foundation
import SwiftUI


enum MyTabItem: Hashable{
    case home, favourites, profile
    
    var iconName: String{
        switch self{
        case .home: return "house.fill"
        case .favourites: return "heart.fill"
        case .profile: return "person.fill"
        }
    }
    
    var title: String{
        switch self{
        case .home: return "Home"
        case .favourites: return "Favourites"
        case .profile: return "Profile"
        }
    }
    
    var color: Color{
        switch self{
        case .home: return Color.blue
        case .favourites: return Color.red
        case .profile: return Color.green
        }
    }
}
