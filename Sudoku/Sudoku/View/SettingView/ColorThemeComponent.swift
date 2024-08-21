//
//  ColorThemeComponent.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import SwiftUI

struct ColorThemeComponent: View {
//    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        HStack{
            Text("Color Theme")
            
            Spacer()
            
            Rectangle()
                .frame(width: 20, height: 30)
                .cornerRadius(10)
                .foregroundStyle(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
                .onTapGesture {
                    themeManager.isDarkMode = false
                }
            
            Rectangle()
                .frame(width: 20, height: 30)
                .cornerRadius(10)
                .foregroundStyle(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 2)
                )
                .onTapGesture {
                    themeManager.isDarkMode = true
                }
        }
//        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }
}

#Preview {
    ColorThemeComponent()
}
