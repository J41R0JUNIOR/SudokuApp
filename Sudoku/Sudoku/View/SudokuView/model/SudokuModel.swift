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
    var editMode: Bool = false
    var rowIndex: Int?
    var columnIndex: Int?
    var frameWidth = (UIScreen.main.bounds.width / 9) * 0.95
    var frameHeight = (UIScreen.main.bounds.width / 9) * 1
     var hilightRC = false

}
