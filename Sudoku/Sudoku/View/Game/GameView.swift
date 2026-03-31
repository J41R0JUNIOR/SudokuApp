//
//  GameView.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//

import SwiftUI
import SwiftData

struct GameView: View {
    
    @Environment(\.modelContext) private var context
    @EnvironmentObject var router: Router
    @EnvironmentObject var theme: ThemeManager

    @State private var viewModel: GameViewModel?
    @State private var isOverlayVisible = true
    
    var body: some View {
        ZStack {
            if let vm = viewModel, let game = vm.gameGrids {
                
                VStack {
                    Text("Mistakes")
                    HStack {
                        Text(game.act_mistakes, format: .number)
                            .foregroundStyle(theme.colors.textWrong)
                        
                        Text("/")
                        
                        Text(game.max_mistakes, format: .number)
                    }
                    
                    GridView(
                        gameGrids: game,
                        selectedCell: vm.selectedCell.map {
                            Indice(row: $0.row, col: $0.col)
                        },
                        onSelectCell: { indice in
                            vm.handleSelection(indice: indice)
                        }
                    )
                    
                    GameKeyboardView(onInput: { val in
                        vm.handleInput(value: val)
                    })
                }
                .foregroundStyle(theme.colors.textPrimary)
                .blur(radius: shouldBlockUI(game: game) ? 3 : 0)
                .disabled(shouldBlockUI(game: game))
                .animation(.easeInOut, value: game.state)
                
                if game.state == GameState.completed.rawValue && isOverlayVisible {
                    overlayView(title: "🎉 You Won!")
                }
                
                if game.state == GameState.failed.rawValue && isOverlayVisible {
                    overlayView(title: "💀 Game Over")
                }
                
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            let repo = SD_Grid_Repository(modelContext: context)
            let vm = GameViewModel(gridRepository: repo)
            
            vm.loadGame()
            self.viewModel = vm
        }
        .onChange(of: viewModel?.gameGrids?.state) { _, newState in
            if newState == GameState.completed.rawValue ||
               newState == GameState.failed.rawValue {
                withAnimation {
                    isOverlayVisible = true
                }
            }
        }
    }
    
    private func shouldBlockUI(game: Grid) -> Bool {
        return game.state != GameState.playing.rawValue && isOverlayVisible
    }

    func overlayView(title: String) -> some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                
                Button("Continue"){
                    isOverlayVisible = false
                }
                
                Button("Back to menu"){
                    router.pop()
                }
            }
            .padding(24)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(radius: 20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.2))
            )
        }
        .foregroundStyle(theme.colors.textPrimary)
        .transition(.opacity.combined(with: .scale))
        .animation(.spring(), value: isOverlayVisible)
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    let haptics = HapticsManager()
    let router = Router()
    let theme = ThemeManager()
    
    return GameView()
        .modelContainer(modelContainer)
        .environmentObject(haptics)
        .environmentObject(router)
        .environmentObject(theme)
}
