//
//  ActionButton.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import SwiftUI
import SwiftData

struct HomeActionButton: View {
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard]
    @EnvironmentObject var haptics: HapticsManager
    var title: String
    var mode: GameSelectionMode
    var dataManager: DataManager?
    var apiCall: ApiCall
    var presentationMode: Binding<PresentationMode>
    var labelWidth: Double
    
    var body: some View {
        Button(action: {
            haptics.callVibration()
            Task {
                do {
                    await apiCall.newGame(mode: mode)
                    let grid = apiCall.gameGrid
                    let solution = apiCall.solutionGrid
                    
                    dataManager?.deleteAllGameBoards(gameBoards: games)

                    dataManager?.addGameBoard(grid: grid, solution: solution, mode: String(describing: mode))
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }, label: {
            Text(title)
                .foregroundStyle(.background)
                .frame(width: UIScreen.main.bounds.width * labelWidth)
        })
    }
}
