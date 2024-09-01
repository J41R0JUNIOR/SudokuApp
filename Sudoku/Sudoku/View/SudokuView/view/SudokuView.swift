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
    
    var body: some View {
        VStack {
            HStack{
                Text("\(games.first?.mode.uppercased() ?? "") MODE").bold()
                
                Spacer()
                
                NavigationLink(value: NavigationContentViewCoordinator.settings) {
                    Image(systemName: "gear").bold()
                        .foregroundStyle(.background)
                }.buttonStyle(.borderedProminent)
                    .cornerRadius(50) 
            }
            Spacer()
            HStack{
                
                Text("Mistakes ")
                    .bold() +
                Text("\(games.first?.actualQtd ?? 0)")
                    .foregroundColor(.red)
                    .bold() +
                Text("/\(games.first?.maxQtd ?? 0)")
                    .bold()

                Spacer()
                
                Button {
                    viewModel.model.editMode.toggle()
                } label: {
                    Image(systemName: "pencil")
                        .bold()
                    viewModel.model.editMode ?Text("On") : Text("Off")
                    
                } .foregroundStyle(.background)
                .buttonStyle(.borderedProminent)
                
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
                                    
                                    let additionalBinding = viewModel.additionalBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)
                                    
                                    
                                    let isHighlighted = rowIndex == viewModel.model.rowIndex || columnIndex == viewModel.model.columnIndex ? true:false
                                    
                                    
                                    if game.grid[rowIndex][columnIndex] == game.gridCopy[rowIndex][columnIndex] && game.grid[rowIndex][columnIndex] != 0 {
                                        
                                        SudokuFinalNumbers(finalNumbeer: numberBinding)
                                            .frame(width: viewModel.model.info.frameWidth, height: viewModel.model.info.frameHeight)
                                            .border(Color.secondary, width: 0.25)
                                            .background(isHighlighted && viewModel.model.hilightRC ? .hilight : .clear)
                                            .onTapGesture {
                                                if rowIndex == viewModel.model.rowIndex && columnIndex == viewModel.model.columnIndex{
                                                    viewModel.model.hilightRC.toggle()
                                                }else{
                                                    viewModel.model.rowIndex = rowIndex
                                                    viewModel.model.columnIndex = columnIndex
                                                    viewModel.model.hilightRC = true
                                                }
                                            }
                                    } else {
                                        
                                        SudokuNumbersComponent(number: numberBinding, correctNumber: correctNumberBinding, additional: additionalBinding)
                                            .frame(width: viewModel.model.info.frameWidth, height: viewModel.model.info.frameHeight)
                                            .border(Color.secondary, width: 0.25)
                                            .background(isHighlighted && viewModel.model.hilightRC ? .hilight : .clear)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                if rowIndex == viewModel.model.rowIndex && columnIndex == viewModel.model.columnIndex{
                                                    viewModel.model.hilightRC.toggle()
                                                }else{
                                                    viewModel.model.rowIndex = rowIndex
                                                    viewModel.model.columnIndex = columnIndex
                                                    viewModel.model.hilightRC = true
                                                }
                                            }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            
            let numberBinding = viewModel.numberToBinding(rowIndex: viewModel.model.rowIndex ?? 0, columnIndex: viewModel.model.columnIndex ?? 0, game: games.first ?? .init(), modelContext: modelContext)
            let correctNumberBinding = viewModel.correctNumberToBinding(rowIndex: viewModel.model.rowIndex ?? 0, columnIndex: viewModel.model.columnIndex ?? 0, game: games.first ?? .init())
            let maxQtdBinding = viewModel.maxQtdToBinding(game: games.first ?? .init())
            let actualQtdBinding = viewModel.actualQtdBinding(game: games.first ?? .init(), modelContext: modelContext)
            let additionalBinding = viewModel.additionalBinding(rowIndex: viewModel.model.rowIndex ?? 0, columnIndex: viewModel.model.columnIndex ?? 0, game: games.first ?? .init(), modelContext: modelContext)
            let restNumbersBinding = viewModel.restNumbersBinding(game: games.first ?? .init(), modelContext: modelContext)
            
            SudokuKeyboard(selectedNumber: numberBinding, correctNumber: correctNumberBinding, maxQtd: maxQtdBinding, actualQtd: actualQtdBinding, showGameOverAlert: $viewModel.model.showGameOverAlert, showFinishAlert: $viewModel.model.showFinishAlert, additional: additionalBinding, restNumber: restNumbersBinding, editMode: $viewModel.model.editMode)
            Spacer()
            
        }
        .padding()
        .alert("You made it.\nGet back to menu?", isPresented: $viewModel.model.showFinishAlert, actions: {
            Button("Yes"){
                presentationMode.wrappedValue.dismiss()
                viewModel.model.dataManager?.deleteAllGameBoards(gameBoards: games)
            }
            
            Button("No", role: .cancel) {}
        })
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
