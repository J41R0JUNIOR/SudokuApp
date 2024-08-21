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
    @State var apiCall = ApiCall()

    var body: some View {
        VStack {
            HomeActionButton(title: "Easy", mode: .easy, dataManager: dataManager, apiCall: apiCall, presentationMode: presentationMode,labelWidth: 0.7)
            HomeActionButton(title: "Medium", mode: .medium, dataManager: dataManager, apiCall: apiCall, presentationMode: presentationMode, labelWidth: 0.8)
            HomeActionButton(title: "Hard", mode: .hard, dataManager: dataManager, apiCall: apiCall, presentationMode: presentationMode, labelWidth: 0.7)
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
