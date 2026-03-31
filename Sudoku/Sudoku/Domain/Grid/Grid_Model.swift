//
//  GameBoard_Model.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//

import Foundation

struct Grid {
    var id: String
    var mistakes: Int
    var state: String
    var incomplete: [[Int8]]
    var complete: [[Int8]]
    var userGrid: [[Int8]]
}
