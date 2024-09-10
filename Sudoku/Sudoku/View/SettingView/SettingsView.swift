//
//  SettingView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vibration = HapticsManager()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ListSelector
            
        }
    }
}

extension SettingsView {
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
                
                Toggle("Vibration", isOn: $vibration.isOnVibrationMode)
                    .toggleStyle(.switch)
            }
            .listRowBackground(Color.hilight)
            
            Section(header: Text("About")) {
                Link("Source Code", destination: URL(string: "https://github.com/J41R0JUNIOR/SudokuApp")!)
            }
            .listRowBackground(Color.hilight)
        }
        .scrollContentBackground(.hidden)

        Spacer()
    }
}

#Preview {
    SettingsView().environmentObject(ThemeManager())
}
