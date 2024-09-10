//
//  SudokuView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 19/08/24.
//

import SwiftUI
import SwiftData

struct SudokuView: View {
    //    var selectedMode: GameSelectionMode?
    @State var viewModel = SudokuViewModel()
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var router: Router
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard] = []
    
    var body: some View {
        VStack {
            NavigationStack(path: $router.path) {
                HStack{
                    Text("\(games.first?.mode.uppercased() ?? "") MODE").bold()
                    
                    Spacer()
                    
                    Button {
                        router.changeRoute(RoutePath(.settings))
                        
                    } label: {
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
               
                
                Grid
                
                
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
        .navigationDestination(for: RoutePath.self) { route in
            route.findPath()
        }
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    let themeManager = ThemeManager()
    let hapticsManager = HapticsManager()
    return SudokuView().modelContainer(modelContent)
        .environmentObject(themeManager)
        .environmentObject(hapticsManager)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
}
