//
//  ProtocolsTest.swift
//  TestingThings
//
//  Created by Greg Ross on 17/08/2022.
//

import SwiftUI


protocol ColorThemeProtocol{
    var primary: Color {get}
    var secondary: Color {get}
    var tertiary: Color {get}
}

struct DefaultColorTheme : ColorThemeProtocol{
    var primary: Color = .blue
    var secondary: Color = .white
    var tertiary: Color = .gray
}


struct AlternativeColorTheme : ColorThemeProtocol{
    var primary: Color = .red
    var secondary: Color = .white
    var tertiary: Color = .green
}


struct AnotherColorTheme : ColorThemeProtocol{
    var primary: Color = .blue
    var secondary: Color = .white
    var tertiary: Color = .purple
}




protocol ButtonTextProtocol{
    var buttonText: String { get set }
}

protocol ButtonPressedProtocol{
    func buttonPressed()
}


protocol ButtonDataSourceProtocol: ButtonPressedProtocol, ButtonTextProtocol{
    
}


class DefaultDataSource : ButtonDataSourceProtocol{
    func buttonPressed() {
        print("\n Button Pressed! \n")
    }
    
    var buttonText: String = "PROTOCOLS ARE WELL GOOD"
}


class AlternativeDataSource : ButtonTextProtocol{
    var buttonText: String = "PROTOCOLS ARE NO GOOD"
}


struct ProtocolsTest: View {
//    let colorTheme: DefaultColorTheme = DefaultColorTheme()
//    let colorTheme: AlternativeColorTheme = AlternativeColorTheme()
    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonDataSourceProtocol
    
    var body: some View {
        ZStack{
            colorTheme.tertiary
                .ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(
                    colorTheme.primary
                )
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.buttonPressed()
                }
            
        }
    }
}

struct ProtocolsTest_Previews: PreviewProvider {
    static var previews: some View {
        ProtocolsTest(colorTheme: DefaultColorTheme(), dataSource: DefaultDataSource())
    }
}
