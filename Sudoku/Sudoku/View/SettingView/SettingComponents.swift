//
//  SettingView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI

struct SettingComponents: View {
    @StateObject var vibration = HapticsManager()
    @State private var notification: Bool = false
    
    @State var path: [String] = [] // Nada na pilha por padrão.
    @State var strs: [String] = ["A", "B", "C", "D"]
    
    var body: some View {
        VStack {
            ListSelector
            
            NavigationStack(path: $path) {
                List {
                    ForEach(strs, id: \.self) { s in
                        NavigationLink(s, value: s)
                    }
                }
                .navigationDestination(for: String.self) { str in
                    TestView(path: $path, strs: $strs, str: str)

                }
            }
        }
    }
}

extension SettingComponents {
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
        }
        .tint(.black)
        .scrollContentBackground(.hidden)
        
        Spacer()
    }
}

#Preview {
    SettingComponents().environmentObject(ThemeManager())
}


struct TestView: View {
    @Binding var path: [String]
    @Binding var strs: [String]
    var str: String
    
    var body: some View {
        VStack {
            Text(str)
            
                if let nextValue = a() {
                    NavigationLink("Go to next", value: nextValue)
                        .buttonStyle(.borderedProminent)
                        .tint(.primary)
                }
        }
    }
    
    func a() -> String? {
        if let indice = strs.firstIndex(of: str) {
            if indice < (strs.count - 1) {
                let nextIndex = indice + 1
                return strs[nextIndex]
            }
        }
        return nil // Retorna nil caso não haja próximo valor
    }
}
