//
//  SettingView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI

struct SettingComponents: View {
    @StateObject var vibration = HapticsManager()
    @StateObject var router = Router.shared // Utilize o Router compartilhado

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ListSelector
            
            NavigationStack(path: $router.path) { // Vincule a rota ao router.shared.path
                VStack {
                    Button {
                        router.changeRoute(RoutePath(.first)) // Chame diretamente a função do router
                    } label: {
                        Text("First View")
                    }
                    Button {
                        router.changeRoute(RoutePath(.second))
                    } label: {
                        Text("Second View")
                    }
                }
                .navigationDestination(for: RoutePath.self) { route in
                    switch route.route {
                    case .first:
                        HomeView()
                        Text("First View content here")
                    case .second:
                        Text("Second View content here")
                    case .none:
                        Text("None")
                    }
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
