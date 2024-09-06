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
    private var gridCopyData: Data
    private var solutionData: Data
    private var additionalData: Data  // Nova propriedade para armazenar os vetores de inteiros
    var mode: String
    var maxQtd: Int
    var actualQtd: Int
    var restNumbers: Int


    var grid: [[Int]] {
        get { (try? JSONDecoder().decode([[Int]].self, from: gridData)) ?? [[]] }
        set { gridData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }
    
    var gridCopy: [[Int]] {
        get { (try? JSONDecoder().decode([[Int]].self, from: gridCopyData)) ?? [[]] }
        set { gridCopyData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }
    
    var solution: [[Int]] {
        get { (try? JSONDecoder().decode([[Int]].self, from: solutionData)) ?? [[]] }
        set { solutionData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }

    var additional: [[[Int]]] {
        get { (try? JSONDecoder().decode([[[Int]]].self, from: additionalData)) ?? [[[Int]]](repeating: [[Int]](repeating: [Int](), count: 9), count: 9) }
        set { additionalData = (try? JSONEncoder().encode(newValue)) ?? Data() }
    }
    
    init(grid: [[Int]] = [[]], solution: [[Int]] = [[]], additional: [[[Int]]] = [[[Int]]](repeating: [[Int]](repeating: [Int](), count: 9), count: 9), mode: String = "", maxQtd: Int = 3, actualQtd: Int = 0, restNumbers: Int = 0) {
        self.gridData = (try? JSONEncoder().encode(grid)) ?? Data()
        self.gridCopyData = (try? JSONEncoder().encode(grid)) ?? Data()
        self.solutionData = (try? JSONEncoder().encode(solution)) ?? Data()
        self.additionalData = (try? JSONEncoder().encode(additional)) ?? Data()
        self.mode = mode
        self.maxQtd = maxQtd
        self.actualQtd = actualQtd
        self.restNumbers = restNumbers
    }
}


