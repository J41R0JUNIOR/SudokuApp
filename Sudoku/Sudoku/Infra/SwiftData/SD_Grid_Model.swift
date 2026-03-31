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
    var act_mistakes: Int
    var max_mistakes: Int
    var state: String
    var incomplete: [[Int8]]
    var complete: [[Int8]]
    var userGrid: [[Int8]]
    
    init (data: Grid) {
        self.id = UUID().uuidString
        self.act_mistakes = data.act_mistakes
        self.max_mistakes = data.max_mistakes
        self.state = data.state
        self.incomplete = data.incomplete
        self.complete = data.complete
        self.userGrid = data.userGrid
    }
    
    func toDomain() -> Grid {
        return Grid(
            id: self.id,
            act_mistakes: self.act_mistakes,
            max_mistakes: self.max_mistakes,
            state: self.state,
            incomplete: self.incomplete,
            complete: self.complete,
            userGrid: self.userGrid
        )
    }
}
