//
//  Untitled.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//

import SwiftUI
import SwiftData

struct HomeSelectionMode: View {
    @EnvironmentObject var haptics: HapticsManager
    @EnvironmentObject var router: Router
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var theme: ThemeManager
    
    let engine: Engine = .shared
    let repository: GridRepository

    var body: some View {
        VStack(spacing: 16) {
            ScrollView(){
                ForEach(GameSelectionMode.allCases, id: \.self) { mode in
                    Button {
                        buttonAction(mode: mode)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(mode.rawValue)
                                    .font(.title3)
                                    .bold()
                                  
                                
                                Text(description(for: mode))
                                    .font(.caption)
                                    .opacity(0.7)
                            }  .foregroundStyle(theme.colors.textSecondary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .opacity(0.5)
                        }
                        .padding()
                        .foregroundStyle(theme.colors.textSecondary)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(theme.colors.primary)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(theme.colors.background.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
                    }
                    .foregroundStyle(theme.colors.textPrimary)
                    .buttonStyle(ScaleButtonStyle())
                }
            }
        }
        .padding()
    }
    
    func buttonAction(mode: GameSelectionMode){
        haptics.callVibration()
        
        let newGrid = engine.generateGrid(mode: mode)
        
        repository.deleteAll()
        repository.create(data: newGrid)
        
        guard let loadedGrid = repository.load() else { return }
        
        presentationMode.wrappedValue.dismiss()
        
        router.push(.sudoku(grid: loadedGrid))
    }
    
    func description(for mode: GameSelectionMode) -> String {
        switch mode {
        case .easy: return "Mommy, i'm scared"
        case .medium: return "I can handle myself"
        case .hard: return "Yeah, let me cook"
        case .extreme: return "I think i lost my mind"
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    let haptics = HapticsManager()
    let router = Router()
    let theme = ThemeManager()
    let context = modelContainer.mainContext
    
    return HomeSelectionMode(repository: SD_Grid_Repository(modelContext: context))
        .modelContainer(modelContainer)
        .environmentObject(haptics)
        .environmentObject(router)
        .environmentObject(theme)
}
