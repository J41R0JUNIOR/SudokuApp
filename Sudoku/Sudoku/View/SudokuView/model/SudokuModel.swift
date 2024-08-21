//
//  SudokuModel.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import Foundation

@Observable
class SudokuModel{
    var grid: [[Int]] = [[]]
    var solution: [[Int]] = [[]]
    var mode: String = ""
    var apiCall: ApiCall = .init()
    var dataManager: DataManager?
}
