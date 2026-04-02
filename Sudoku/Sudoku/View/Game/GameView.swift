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
    
    let grid: Grid
    
    var body: some View {
        ZStack {
            if let vm = viewModel {
                
                VStack {
                    
                    Text("Mistakes")
                    
                    HStack {
                        Text(vm.grid.act_mistakes, format: .number)
                            .foregroundStyle(theme.colors.textWrong)
                        
                        Text("/")
                        
                        Text(vm.grid.max_mistakes, format: .number)
                    }
                    
                    GridView(
                        cells: vm.cells,
                        selectedCell: vm.selectedCell.map {
                            Indice(row: $0.row, col: $0.col)
                        },
                        onSelectCell: { indice in
                            vm.handleSelection(indice: indice)
                        }
                    )
                    
                    GameKeyboardView { val in
                        vm.handleInput(value: val)
                    }
                }
                .foregroundStyle(theme.colors.textPrimary)
                .blur(radius: shouldBlockUI(game: vm.grid) ? 3 : 0)
                .disabled(shouldBlockUI(game: vm.grid))
                .animation(.easeInOut, value: vm.grid.state)
                
                if vm.grid.state == GameState.completed.rawValue && isOverlayVisible {
                    overlayView(title: "🎉 You Won!")
                }
                
                if vm.grid.state == GameState.failed.rawValue && isOverlayVisible {
                    overlayView(title: "Game Over")
                }
                
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            let repo = SD_Grid_Repository(modelContext: context)
            self.viewModel = GameViewModel(gridRepository: repo, grid: grid)
        }
        .onChange(of: viewModel?.grid.state) { _, newState in
            if newState == GameState.completed.rawValue ||
               newState == GameState.failed.rawValue {
                withAnimation {
                    isOverlayVisible = true
                }
            }
        }
    }
    
    private func shouldBlockUI(game: Grid) -> Bool {
        game.state != GameState.playing.rawValue && isOverlayVisible
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
    
    let g = Grid(
        id: "1",
        act_mistakes:0,
        max_mistakes: 3,
        state: GameState.playing.rawValue,
        
        incomplete: [
            [5,3,0, 0,7,0, 0,0,0],
            [6,0,0, 1,9,5, 0,0,0],
            [0,9,8, 0,0,0, 0,6,0],

            [8,0,0, 0,6,0, 0,0,3],
            [4,0,0, 8,0,3, 0,0,1],
            [7,0,0, 0,2,0, 0,0,6],

            [0,6,0, 0,0,0, 2,8,0],
            [0,0,0, 4,1,9, 0,0,5],
            [0,0,0, 0,8,0, 0,7,9]
        ],
        
        complete: [
            [5,3,4, 6,7,8, 9,1,2],
            [6,7,2, 1,9,5, 3,4,8],
            [1,9,8, 3,4,2, 5,6,7],

            [8,5,9, 7,6,1, 4,2,3],
            [4,2,6, 8,5,3, 7,9,1],
            [7,1,3, 9,2,4, 8,5,6],

            [9,6,1, 5,3,7, 2,8,4],
            [2,8,7, 4,1,9, 6,3,5],
            [3,4,5, 2,8,6, 1,7,9]
        ],
        
        userGrid: [
            [5,3,0, 6,7,7, 9,1,2],
            [6,7,2, 1,9,5, 3,4,8],
            [1,9,8, 3,4,2, 5,6,7],

            [8,5,9, 7,6,1, 4,2,3],
            [4,2,6, 8,5,3, 7,9,1],
            [7,1,3, 9,2,4, 8,5,6],

            [9,6,1, 5,3,7, 2,8,4],
            [2,8,7, 4,1,9, 0,0,5],
            
            [3,4,5, 3,8,5, 1,7,1]
        ]
    )
    
    return GameView(grid: g)
        .modelContainer(modelContainer)
        .environmentObject(haptics)
        .environmentObject(router)
        .environmentObject(theme)
}
