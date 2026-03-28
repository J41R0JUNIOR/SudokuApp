//
//  GameBoard.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation
import SwiftData

@Model
class SD_Grid_Model {
    var id: String
    var incomplete: [[Int8]]
    var complete: [[Int8]]
    var userGrid: [[Int8]]
    
    init (data: Grid) {
        self.id = UUID().uuidString
        self.incomplete = data.incomplete
        self.complete = data.complete
        self.userGrid = data.userGrid
    }
    
    func toDomain() -> Grid {
        return Grid(
            id: self.id,
            incomplete: self.incomplete,
            complete: self.complete,
            userGrid: self.userGrid
        )
    }
}


