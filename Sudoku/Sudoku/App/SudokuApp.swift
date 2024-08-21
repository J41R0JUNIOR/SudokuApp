//
//  SudokuApp.swift
//  Sudoku
//
//  Created by Jairo Júnior on 19/08/24.
//

import SwiftUI

@main
struct SudokuApp: App {
    
//    init(){
//        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .red
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: GameBoard.self)
    }
}
