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
    
    @State var choice: GameSelectionMode = .medium
    @State var showAlert = false
    @State var showNewGameSheet = false
    @State var dataManager: DataManager?
    
    var body: some View {
        VStack {
            if !games.isEmpty {
                NavigationLink(value: NavigationContentViewCoordinator.sudoku(selectedMode: choice)) {
                    Text("Continue")
                }
            }
            
            if !games.isEmpty{
                Button("New game") {
                    showAlert.toggle()
                }
                .alert("Are you sure? It'll delete your progress", isPresented: $showAlert) {
                    Button("Yes") {
                        showAlert.toggle()
                        showNewGameSheet.toggle()
                    }
                    Button("No", role: .cancel, action: {})
                }
                .sheet(isPresented: $showNewGameSheet) {
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
            dataManager = DataManager(modelContext: modelContext)
        })
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    return HomeView()
        .navigationLinkValues(NavigationContentViewCoordinator.self)
        .modelContainer(modelContent)
}
