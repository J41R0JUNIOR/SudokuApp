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
    case sudokuNumbers(number: Binding<Int>)
    
    
    var body: some View {
        
        switch self {
        case .home:
            HomeView()
        
        case .homeSelectionMode:
            HomeSelectionMode()
            
        case .sudoku(let selectedMode):
            SudokuView(selectedMode: selectedMode)
            
        case .sudokuNumbers(number: let number):
            SudokuKeyBoard(selectedNumber: number)
            
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
