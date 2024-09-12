//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import Foundation
import SwiftUI

@Observable
class SudokuModel{
    var grid: [[Int]] = [[]]
    var solution: [[Int]] = [[]]
    var mode: String = ""
    var dataManager: DataManager?
    var showGameOverAlert: Bool = false
    var showFinishAlert: Bool = false
//    var editMode: Bool = false
    var rowIndex: Int?
    var columnIndex: Int?
    var info: InfoData = .init()
    var hilightRC = false
    var rowHilight: Rectangle = .init()
    var columnHilight: Rectangle = .init()
    var gameState = GameState.playing
}
