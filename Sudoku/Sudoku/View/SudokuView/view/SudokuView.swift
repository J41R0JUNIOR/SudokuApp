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
//        @Bindable viewModel = viewModel
        VStack {
            Text("Mode: \(games.first?.mode ?? "")")
            Text("Quantity \(games.first?.maxQtd ?? 0)")
            
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
                                    
                                    let maxQtdBinding = viewModel.maxQtdToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)
                                    
//                                    let numberBinding = Binding(
//                                        get: { game.grid[rowIndex][columnIndex] },
//                                        set: { newValue in
//                                            game.grid[rowIndex][columnIndex] = newValue
//                                            try? modelContext.save()
//                                        }
//                                    ) 
//                                    
//                                    let correctNumberBinding = Binding(
//                                        get: { game.solution[rowIndex][columnIndex] },
//                                        set: { _ in}
//                                    )
//                                    
//                                    let maxQtdBinding = Binding (
//                                        get: { game.solution[rowIndex][columnIndex] },
//                                        set: { newValue in
//                                            game.maxQtd = newValue
//                                            try? modelContext.save()
//                                        }
//                                    )
                                    
                                    
                                    
                                    
                                    if game.grid[rowIndex][columnIndex] == game.gridCopy[rowIndex][columnIndex] && game.grid[rowIndex][columnIndex] != 0 {
                                        
                                        SudokuFinalNumbers(finalNumbeer: numberBinding)
                                            .frame(width: frameWidth, height: frameHeight)
                                            .border(Color.secondary, width: 0.25)
                                    } else {
                                        //
                                        //                                        SudokuNumbersComponent(number: numberBinding, correctNumber: correctNumberBinding, maxQtd: maxQtdBinding)
                                        SudokuNumbersComponent(number: numberBinding, correctNumber: correctNumberBinding, maxQtd: maxQtdBinding)
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
