//
//  SettingView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vibration = HapticsManager()
//    @Bindable var router = Router.shared
    

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ListSelector
            
//            NavigationStack(path: $router.path) {
//                VStack {
//                    Button {
//                        router.changeRoute(RoutePath(.home))
//                    } label: {
//                        Text("First View")
//                    }
//                    Button {
//                        router.changeRoute(RoutePath(.sudoku))
//                    } label: {
//                        Text("Second View")
//                    }
//                }
//
//                .navigationDestination(for: RoutePath.self) { route in
//                    route.findPath()
//                }
//            }
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
        }
        .tint(.black)
        .scrollContentBackground(.hidden)
        
        Spacer()
    }
}

#Preview {
    SettingsView().environmentObject(ThemeManager())
}
