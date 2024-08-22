//
//  SettingView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI

struct SettingComponents: View {
    @State var vibration: Bool = false
    @State var notification: Bool = false
    
    var body: some View {
        VStack {
            ListSelector
        }
        
    }
    
}
extension SettingComponents{
    
    @ViewBuilder
    private var ListSelector: some View {
        Text("Settings")
            .font(.largeTitle)
            .bold()
            .padding()
        
        Spacer()
        List {
            Section(header: Text("Your style")) {
                ColorThemeComponent()
                
                Toggle("Vibration", isOn: $vibration)
                    .toggleStyle(.switch)
                
                Toggle("Notification", isOn: $notification)
                    .toggleStyle(.switch)
            }
            
            Section(header: Text("Game Preferences")) {
                Text("Auto-complete")
                Text("etc...")
            }
        }
        .tint(.black)
        .scrollContentBackground(.hidden)
        
        Spacer()
    }
}

#Preview {
    SettingComponents().environmentObject(ThemeManager())
}
