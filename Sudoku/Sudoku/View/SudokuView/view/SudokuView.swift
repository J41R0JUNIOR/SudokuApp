//
//  SudokuView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 19/08/24.
//

import SwiftUI
import SwiftData

struct SudokuView: View {
    @Bindable var viewModel = SudokuViewModel()
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var router: Router
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard] = []
    
    var body: some View {
        VStack {
                HStack{
                    Text("\(games.first?.mode.uppercased() ?? "") MODE").bold()
                    
                    Spacer()
                    
                    Button {
                        router.push(.settings)
                        
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.foreground)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.clear)
                    
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
                        viewModel.model.gameState = viewModel.model.gameState == .playing ? .editing : .playing
                    } label: {
                        Image(systemName: "pencil")
                            .bold()
                        viewModel.model.gameState == .editing ? Text("On") : Text("Off")
                        
                    } .foregroundStyle(.background)
                        .buttonStyle(.borderedProminent)
                    
                }
               
                
                Grid
                
                KeyBoard
               
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
//    let themeManager = ThemeManager()
//    let hapticsManager = HapticsManager()
    return SudokuView().modelContainer(modelContent)
//        .environmentObject(themeManager)
//        .environmentObject(hapticsManager)
//        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
}
