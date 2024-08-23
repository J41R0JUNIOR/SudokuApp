//
//  SudokuView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 19/08/24.
//

import SwiftUI
import SwiftData

struct SudokuView: View {
    var selectedMode: GameSelectionMode?
    @State private var viewModel = SudokuViewModel()
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard] = []
    
    var frameWidth = (UIScreen.main.bounds.width / 9) * 0.95
    var frameHeight = (UIScreen.main.bounds.width / 9) * 1
    
    var body: some View {
        VStack {
            Text("Mode: \(games.first?.mode ?? "")")
            Text("Mistakes \(games.first?.actualQtd ?? 0)/\(games.first?.maxQtd ?? 0)")
            
            Spacer()
            
            ZStack {
                Grid3x3View()
                VStack(spacing: 0) {
                    ForEach(games.first?.grid.indices ?? [].indices, id: \.self) { rowIndex in
                        HStack(spacing: 0) {
                            ForEach(games.first?.grid[rowIndex].indices ?? [].indices, id: \.self) { columnIndex in
                                
                                if let game = games.first {
                                    let numberBinding = viewModel.numberToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)
                                    let correctNumberBinding = viewModel.correctNumberToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game)
                                    let maxQtdBinding = viewModel.maxQtdToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game)
                                    let actualQtdBinding = viewModel.actualQtdBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)
//                                    let gamesBinding = viewModel.gamesBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: games, modelContext: modelContext)
                                    
                                    
                                    
                                    if game.grid[rowIndex][columnIndex] == game.gridCopy[rowIndex][columnIndex] && game.grid[rowIndex][columnIndex] != 0 {
                                        
                                        SudokuFinalNumbers(finalNumbeer: numberBinding)
                                            .frame(width: frameWidth, height: frameHeight)
                                            .border(Color.secondary, width: 0.25)
                                    } else {
                                
                                        SudokuNumbersComponent(number: numberBinding, correctNumber: correctNumberBinding, maxQtd: maxQtdBinding, actualQtd: actualQtdBinding/*, games: gamesBinding*/)
                                            .frame(width: frameWidth, height: frameHeight)
                                            .border(Color.secondary, width: 0.25)
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.model.dataManager = DataManager(modelContext: modelContext)
        }
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    return SudokuView(selectedMode: .medium).modelContainer(modelContent)
}
