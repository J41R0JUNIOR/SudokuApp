//
//  Engine.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//
import Foundation

class Engine: ObservableObject {
    
    public static let shared = Engine()
    
    func generateGrid(mode: GameSelectionMode) -> Grid {
        var k = 30
        
        switch mode {
        case .easy: k = 30
        case .medium: k = 40
        case .hard: k = 50
        }
        
        return generateGrid(k: k)
    }
        
    func generateGrid(k: Int, max_mistakes: Int = 3) -> Grid {
        var grid = Array(repeating: Array(repeating: Int8(0), count: 9), count: 9)
        
        fillDiagonal(grid: &grid)
        
        _ = fillRemaining(grid: &grid, i: 0, j: 0)
        
        let complete = grid
        
        let incomplete = removeNumbers(grid: grid, k: k)
        
        return Grid(
            id: UUID().uuidString,
            act_mistakes: 0,
            max_mistakes: max_mistakes,
            state: GameState.playing.rawValue,
            incomplete: incomplete,
            complete: complete,
            userGrid: incomplete
        )
    }
    
    func getCellValue(
        incomplete: [[Int8]],
        userGrid: [[Int8]],
        row: Int,
        col: Int
    ) -> Int8 {
        return incomplete[row][col] != 0
            ? incomplete[row][col]
            : userGrid[row][col]
    }
   
    func canEditCell(
        incomplete: [[Int8]],
        row: Int,
        col: Int
    ) -> Bool {
        return incomplete[row][col] == 0
    }
   
    func isCorrect(
        userGrid: [[Int8]],
        complete: [[Int8]],
        row: Int,
        col: Int
    ) -> Bool {
        return userGrid[row][col] != 0 &&
                userGrid[row][col] == complete[row][col]
    }
   
    func isWrong(
        userGrid: [[Int8]],
        complete: [[Int8]],
        row: Int,
        col: Int
    ) -> Bool {
        return userGrid[row][col] != 0 &&
                userGrid[row][col] != complete[row][col]
    }
        
    private func fillDiagonal(grid: inout [[Int8]]) {
        for i in stride(from: 0, to: 9, by: 3) {
            fillBox(grid: &grid, row: i, col: i)
        }
    }
        
    private func fillBox(grid: inout [[Int8]], row: Int, col: Int) {
        var num: Int8
        
        for i in 0..<3 {
            for j in 0..<3 {
                repeat {
                    num = Int8.random(in: 1...9)
                } while !unUsedInBox(grid: grid, rowStart: row, colStart: col, num: num)
                
                grid[row + i][col + j] = num
            }
        }
    }
    
    private func unUsedInBox(grid: [[Int8]], rowStart: Int, colStart: Int, num: Int8) -> Bool {
        for i in 0..<3 {
            for j in 0..<3 {
                if grid[rowStart + i][colStart + j] == num {
                    return false
                }
            }
        }
        return true
    }
    
    private func unUsedInRow(grid: [[Int8]], row: Int, num: Int8) -> Bool {
        for col in 0..<9 {
            if grid[row][col] == num {
                return false
            }
        }
        return true
    }
    
    private func unUsedInCol(grid: [[Int8]], col: Int, num: Int8) -> Bool {
        for row in 0..<9 {
            if grid[row][col] == num {
                return false
            }
        }
        return true
    }
    
    private func checkIfSafe(grid: [[Int8]], i: Int, j: Int, num: Int8) -> Bool {
        return unUsedInRow(grid: grid, row: i, num: num)
        && unUsedInCol(grid: grid, col: j, num: num)
        && unUsedInBox(
            grid: grid,
            rowStart: i - i % 3,
            colStart: j - j % 3,
            num: num
        )
    }
        
    private func fillRemaining(grid: inout [[Int8]], i: Int, j: Int) -> Bool {
        
        if i == 9 {
            return true
        }
        
        if j == 9 {
            return fillRemaining(grid: &grid, i: i + 1, j: 0)
        }
        
        if grid[i][j] != 0 {
            return fillRemaining(grid: &grid, i: i, j: j + 1)
        }
        
        for num in 1...9 {
            let value = Int8(num)
            
            if checkIfSafe(grid: grid, i: i, j: j, num: value) {
                grid[i][j] = value
                
                if fillRemaining(grid: &grid, i: i, j: j + 1) {
                    return true
                }
                
                grid[i][j] = 0
            }
        }
        
        return false
    }
        
    private func removeNumbers(grid: [[Int8]], k: Int) -> [[Int8]] {
        var newGrid = grid
        var remaining = k
        
        while remaining > 0 {
            let cellId = Int.random(in: 0..<81)
            
            let i = cellId / 9
            let j = cellId % 9
            
            if newGrid[i][j] == 0 { continue }
            
            let backup = newGrid[i][j]
            newGrid[i][j] = 0
            
            var copy = newGrid
            let solutions = countSolutions(grid: &copy)
            
            if solutions != 1 {
                newGrid[i][j] = backup
            } else {
                remaining -= 1
            }
        }
        
        return newGrid
    }
    
    private func countSolutions(grid: inout [[Int8]], limit: Int = 2) -> Int {
        var count = 0
        
        func solve(_ i: Int, _ j: Int) {
            if count >= limit { return }
            
            if i == 9 {
                count += 1
                return
            }
            
            let nextI = j == 8 ? i + 1 : i
            let nextJ = j == 8 ? 0 : j + 1
            
            if grid[i][j] != 0 {
                solve(nextI, nextJ)
            } else {
                for num in 1...9 {
                    let value = Int8(num)
                    
                    if checkIfSafe(grid: grid, i: i, j: j, num: value) {
                        grid[i][j] = value
                        solve(nextI, nextJ)
                        grid[i][j] = 0
                    }
                }
            }
        }
        
        solve(0, 0)
        return count
    }
    
    func makeMove(
        grid: inout Grid,
        row: Int,
        col: Int,
        value: Int8
    ) {
        if grid.state != GameState.playing.rawValue { return }
        
        guard canEditCell(incomplete: grid.incomplete, row: row, col: col) else {
            return
        }
        
        grid.userGrid[row][col] = value
        
        if isWrong(userGrid: grid.userGrid, complete: grid.complete, row: row, col: col) {
            grid.act_mistakes += 1
            
            if grid.act_mistakes >= grid.max_mistakes {
                grid.state = GameState.failed.rawValue
            }
        }
        
        if checkIfCompleted(grid: grid) {
            grid.state = GameState.completed.rawValue
        }
    }
    
    func checkIfCompleted(grid: Grid) -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                if grid.userGrid[i][j] != grid.complete[i][j] {
                    return false
                }
            }
        }
        return true
    }
}
