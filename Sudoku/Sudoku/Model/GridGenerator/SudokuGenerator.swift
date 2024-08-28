//
//  SudokuGenerator.swift
//  Sudoku
//
//  Created by Jairo Júnior on 27/08/24.
//

import Foundation



class SudokuGenerator{
    let size = 9
    var gameArray: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    var easyMode: [[Int]] = [[]]
    var mediumMode: [[Int]] = [[]]
    var hardMode: [[Int]] = [[]]
    
    init() {
        _ = fillGrid()
        self.easyMode = removeNumbers(qtd: 25)
        self.mediumMode = removeNumbers(qtd: 45)
        self.hardMode = removeNumbers(qtd: 62)
        
    }
    
    func getGame(mode: GameSelectionMode) -> [[Int]]{
        switch mode {
        case .easy:
            return easyMode
        case .medium:
            return mediumMode
        case .hard:
            return hardMode
        }
    }
    
    func fillGrid() -> Bool {
        for i in 0..<size {
            for j in 0..<size {
                if gameArray[i][j] == 0 {
                    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled()
                    for num in numbers {
                        if isValid(number: num, row: i, col: j) {
                            gameArray[i][j] = num
                            if fillGrid() {
                                return true
                            }
                            gameArray[i][j] = 0
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    func isValid(number: Int, row: Int, col: Int) -> Bool {
        return !findNumberInRow(number: number, row: row) &&
        !findNumberInColumn(number: number, column: col) &&
        !findNumberInBox(number: number, i: row, j: col)
    }
    
    func findNumberInRow(number: Int, row: Int) -> Bool {
        return gameArray[row].contains(number)
    }
    
    func findNumberInColumn(number: Int, column: Int) -> Bool{
        for i in gameArray{
            if i[column] == number{
                return true
            }
        }
        return false
    }
    
    func findNumberInBox(number: Int, i: Int, j: Int) -> Bool {
        let boxRow = (i / 3) * 3
        let boxCol = (j / 3) * 3
        
        for r in boxRow..<boxRow + 3 {
            for c in boxCol..<boxCol + 3 {
                if gameArray[r][c] == number {
                    return true
                }
            }
        }
        return false
    }
    
    func removeNumbers(qtd: Int) -> [[Int]]{
        var gameCopy = gameArray
        var count = 0
        
        while count < qtd{
            let i = Int.random(in: 0..<9)
            let j = Int.random(in: 0..<9)
            
            if gameCopy[i][j] != 0{
                gameCopy[i][j] = 0
                count += 1
            }
        }
        return gameCopy
    }

}
