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
    
    @State private var viewModel: GameViewModel?
    
    var body: some View {
        VStack {
            if let vm = viewModel, let game = vm.gameGrids {
                
                GridView(
                    gameGrids: game,
                    selectedCell: vm.selectedCell.map {
                        Indice(row: $0.row, col: $0.col)
                    },
                    onSelectCell: { indice in
                        vm.selectedCell = (indice.row, indice.col)
                    }
                )
                
                GameKeyboardView(onInput: { val in
                    vm.handleInput(value: val)
                })
                
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
    }
}
