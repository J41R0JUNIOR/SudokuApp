//
//  HomeRootCoordinator.swift
//  EnumNavigatorAndSwiftData
//
//  Created by Jairo Júnior on 29/04/24.
//

import SwiftUI

enum NavigationContentViewCoordinator: View{
    case home
    case homeSelectionMode
    case sudoku(selectedMode: GameSelectionMode)
    case sudokuNumbers(number: Binding<Int>, correctNumber: Binding<Int>, maxQtd: Binding<Int>, actualQtd: Binding<Int>, showGameOverAlert: Binding<Bool>, additional: Binding<[Int]>, editMode: Binding<Bool>)
    
    
    var body: some View {
        
        switch self {
        case .home:
            HomeView()
        
        case .homeSelectionMode:
            HomeSelectionMode()
            
        case .sudoku(let selectedMode):
            SudokuView(selectedMode: selectedMode)
            
        case .sudokuNumbers(number: let number, correctNumber: let correctNumber, maxQtd: let maxQtd, actualQtd: let actualQtd, let showGameOverAlert, let additional, let editMode):
            SudokuKeyboard(selectedNumber: number, correctNumber: correctNumber, maxQtd: maxQtd, actualQtd: actualQtd, showGameOverAlert: showGameOverAlert, additional: additional, editMode: editMode)
            
        }
    }
}


extension NavigationContentViewCoordinator: Equatable, Hashable{
    static func == (lhs: NavigationContentViewCoordinator, rhs: NavigationContentViewCoordinator) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        
        switch self {
        default:
            hasher.combine("\(self)")
        }
    }
}
