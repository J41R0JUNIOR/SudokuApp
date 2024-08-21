//
//  GameBoard.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation
import SwiftData

@Model
class GameBoard {
    private var gridData: Data
    private var solutionData: Data
    var mode: String

    var grid: [[Int]] {
        get {
            (try? JSONDecoder().decode([[Int]].self, from: gridData)) ?? [[]]
        }
        set {
            gridData = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }
    
    var solution: [[Int]] {
        get {
            (try? JSONDecoder().decode([[Int]].self, from: solutionData)) ?? [[]]
        }
        set {
            solutionData = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }
    
    init(grid: [[Int]] = [[]], solution: [[Int]] = [[]], mode: String = "") {
        self.gridData = (try? JSONEncoder().encode(grid)) ?? Data()
        self.solutionData = (try? JSONEncoder().encode(solution)) ?? Data()
        self.mode = mode
    }
}

