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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
   
    
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard] = []
    
    var frameWidth = (UIScreen.main.bounds.width / 9) * 0.95
    var frameHeight = (UIScreen.main.bounds.width / 9) * 1
    
    var body: some View {
        VStack {
            Text("\(games.first?.mode.uppercased() ?? "") MODE").bold()
            Spacer()
            HStack{
                Text("Mistakes \(games.first?.actualQtd ?? 0)/\(games.first?.maxQtd ?? 0)")
                Spacer()
//                Toggle("| Edit Mode", isOn: $viewModel.model.editMode)
                Button {
                    viewModel.model.editMode.toggle()
                } label: {
                    if viewModel.model.editMode{
                        Text("Edit Mode\nOn")
                    }else{
                        Text("Edit Mode\nOff")
                    }
                }

            }
            ZStack {
                Grid3x3View()
                VStack(spacing: 0) {
                    ForEach(games.first?.grid.indices ?? [].indices, id: \.self) { rowIndex in
                        HStack(spacing: 0) {
                            ForEach(games.first?.grid[rowIndex].indices ?? [].indices, id: \.self) { columnIndex in
                                
                                if let game = games.first {
                                    let numberBinding = viewModel.numberToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)
                                    let correctNumberBinding = viewModel.correctNumberToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game)
                                    let maxQtdBinding = viewModel.maxQtdToBinding(game: game)
                                    let actualQtdBinding = viewModel.actualQtdBinding(game: game, modelContext: modelContext)
                                    let additionalBinding = viewModel.additionalBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)
                                    
                                    
                                    
                                    if game.grid[rowIndex][columnIndex] == game.gridCopy[rowIndex][columnIndex] && game.grid[rowIndex][columnIndex] != 0 {
                                        
                                        SudokuFinalNumbers(finalNumbeer: numberBinding)
                                            .frame(width: frameWidth, height: frameHeight)
                                            .border(Color.secondary, width: 0.25)
                                    } else {
                                
                                        SudokuNumbersComponent(number: numberBinding, correctNumber: correctNumberBinding, maxQtd: maxQtdBinding, actualQtd: actualQtdBinding, showGameOverAlert: $viewModel.model.showGameOverAlert, additional: additionalBinding, editMode: $viewModel.model.editMode)
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
        }.padding()
        .alert("Game Over\nGet back to menu?", isPresented: $viewModel.model.showGameOverAlert) {
            Button("Yes"){
                presentationMode.wrappedValue.dismiss()
                viewModel.model.dataManager?.deleteAllGameBoards(gameBoards: games)
            }
            Button("No", role: .cancel) {}
        }
        .onAppear {
            viewModel.model.dataManager = DataManager(modelContext: modelContext)
        }
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    let themeManager = ThemeManager()
    let hapticsManager = HapticsManager()
    return SudokuView(selectedMode: .medium).modelContainer(modelContent)
        .environmentObject(themeManager)
        .environmentObject(hapticsManager)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
}
