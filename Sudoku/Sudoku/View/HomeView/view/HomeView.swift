//
//  HomeView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//
import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard]
//    @Bindable var games: [GameBoard]?
    @Bindable var viewModel = HomeViewModel()
    
    
    
    var body: some View {
        VStack {
            if !games.isEmpty {
                NavigationLink(value: NavigationContentViewCoordinator.sudoku(selectedMode: viewModel.choice)) {
                    Text("Continue")
                }
            }
            
            if !games.isEmpty{
                Button("New game") {
                    viewModel.showAlert.toggle()
                }
                .alert("Are you sure? It'll delete your progress", isPresented: $viewModel.showAlert) {
                    Button("Yes") {
                        viewModel.showAlert.toggle()
                        viewModel.showNewGameSheet.toggle()
                    }
                    Button("No", role: .cancel, action: {})
                }
                .sheet(isPresented: $viewModel.showNewGameSheet) {
                    HomeSelectionMode().presentationDetents([.fraction(0.3)])
                }
            }else{
                NavigationModal(.sheet, value: NavigationContentViewCoordinator.homeSelectionMode, data: NavigationContentViewCoordinator.self, presentationDetents: [.fraction(0.3)]) {
                    Text("New game")
                } asyncFunction: {}
            }
        }
        .buttonStyle(.borderedProminent)
        .onAppear(perform: {
            viewModel.dataManager = DataManager(modelContext: modelContext)
        })
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    return HomeView()
        .navigationLinkValues(NavigationContentViewCoordinator.self)
        .modelContainer(modelContent)
}
