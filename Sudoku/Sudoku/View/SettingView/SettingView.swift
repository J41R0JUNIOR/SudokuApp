//
//  SettingView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI

struct SettingView: View {
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            ColorThemeComponent()
            
            Spacer()
        }
        .padding()
       
    }
}

#Preview {
    SettingView()
}
