//
//  SelectionGameMode.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI
import SwiftData

struct HomeSelectionMode: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard]
    
    @State var selectedMode: GameSelectionMode?
    @State var hasChosen: Bool?
    @State var dataManager: DataManager?

    var body: some View {
        VStack {
            Text("Chose the gamemode:").bold()
            HomeActionButton(title: "Easy", mode: .easy, dataManager: dataManager, presentationMode: presentationMode,labelWidth: 0.8)
            HomeActionButton(title: "Medium", mode: .medium, dataManager: dataManager, presentationMode: presentationMode, labelWidth: 0.8)
            HomeActionButton(title: "Hard", mode: .hard, dataManager: dataManager,presentationMode: presentationMode, labelWidth: 0.8)
        }
        .buttonStyle(.borderedProminent)
        .onAppear(perform: {
            dataManager = DataManager(modelContext: modelContext)
        })
    }
}

#Preview {
    HomeSelectionMode().navigationLinkValues(NavigationContentViewCoordinator.self)
}
