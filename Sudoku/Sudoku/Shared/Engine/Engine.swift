//
//  Engine.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//
import Foundation

class Engine: ObservableObject {
    
    public static let shared = Engine()
    
    // MARK: - Public
    
    func generateGrid(mode: GameSelectionMode) -> Grid {
        let k: Int
        var m: Int = 3
        
        switch mode {
        case .easy: k = 30
        case .medium: k = 40
        case .hard: k = 50
        case .extreme: k = 55; m = 1
        }
        
        return generateGrid(k: k, max_mistakes: m)
    }
    
    func generateGrid(k: Int, max_mistakes: Int = 3) -> Grid {
        var grid = Array(repeating: Array(repeating: Int8(0), count: 9), count: 9)
        
        fillDiagonal(grid: &grid)
        _ = fillRemaining(grid: &grid)
        
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
        let fixed = incomplete[row][col]
        return fixed != 0 ? fixed : userGrid[row][col]
    }
    
    func canEditCell(incomplete: [[Int8]], row: Int, col: Int) -> Bool {
        incomplete[row][col] == 0
    }
    
    func isWrong(userGrid: [[Int8]], complete: [[Int8]], row: Int, col: Int) -> Bool {
        userGrid[row][col] != 0 && userGrid[row][col] != complete[row][col]
    }
    
    func isCorrect(userGrid: [[Int8]], complete: [[Int8]], row: Int, col: Int) -> Bool {
        userGrid[row][col] != 0 && userGrid[row][col] == complete[row][col]
    }
        
    private func fillDiagonal(grid: inout [[Int8]]) {
        for i in stride(from: 0, to: 9, by: 3) {
            fillBox(grid: &grid, row: i, col: i)
        }
    }
    
    private func fillBox(grid: inout [[Int8]], row: Int, col: Int) {
        let numbers = (1...9).shuffled()
        var idx = 0
        
        for i in 0..<3 {
            for j in 0..<3 {
                grid[row + i][col + j] = Int8(numbers[idx])
                idx += 1
            }
        }
    }
    
    private func fillRemaining(grid: inout [[Int8]]) -> Bool {
        guard let (i, j) = findBestCell(grid: grid) else {
            return true
        }
        
        let numbers = (1...9).shuffled()
        
        for num in numbers {
            let val = Int8(num)
            
            if isSafe(grid: grid, i: i, j: j, num: val) {
                grid[i][j] = val
                
                if fillRemaining(grid: &grid) {
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
        
        let cells = Array(0..<81).shuffled()
        var attempts = 0
        let maxAttempts = 200
        
        for cellId in cells {
            if remaining <= 0 || attempts >= maxAttempts { break }
            attempts += 1
            
            let i = cellId / 9
            let j = cellId % 9
            
            let mi = 8 - i
            let mj = 8 - j
            
            if newGrid[i][j] == 0 { continue }
            
            let backup1 = newGrid[i][j]
            let backup2 = newGrid[mi][mj]
            
            newGrid[i][j] = 0
            newGrid[mi][mj] = 0
            
            if attempts % 3 != 0 {
                remaining -= (i == mi && j == mj) ? 1 : 2
                continue
            }
            
            var copy = newGrid
            let solutions = countSolutions(grid: &copy, limit: 2)
            
            if solutions != 1 {
                newGrid[i][j] = backup1
                newGrid[mi][mj] = backup2
            } else {
                remaining -= (i == mi && j == mj) ? 1 : 2
            }
        }
        
        return newGrid
    }
        
    private func countSolutions(grid: inout [[Int8]], limit: Int = 2) -> Int {
        var count = 0
        
        func solve() {
            if count >= limit { return }
            
            guard let (i, j) = findBestCell(grid: grid) else {
                count += 1
                return
            }
            
            let numbers = (1...9).shuffled()
            
            for num in numbers {
                if count >= limit { return }
                
                let val = Int8(num)
                
                if isSafe(grid: grid, i: i, j: j, num: val) {
                    grid[i][j] = val
                    solve()
                    grid[i][j] = 0
                }
            }
        }
        
        solve()
        return count
    }
        
    private func findBestCell(grid: [[Int8]]) -> (Int, Int)? {
        var minOptions = 10
        var best: (Int, Int)?
        
        for i in 0..<9 {
            for j in 0..<9 {
                if grid[i][j] == 0 {
                    var options = 0
                    
                    for num in 1...9 {
                        if isSafe(grid: grid, i: i, j: j, num: Int8(num)) {
                            options += 1
                        }
                    }
                    
                    if options < minOptions {
                        minOptions = options
                        best = (i, j)
                        
                        if options == 1 { return best }
                    }
                }
            }
        }
        
        return best
    }
        
    private func isSafe(grid: [[Int8]], i: Int, j: Int, num: Int8) -> Bool {
        for x in 0..<9 {
            if grid[i][x] == num || grid[x][j] == num {
                return false
            }
        }
        
        let row = i - i % 3
        let col = j - j % 3
        
        for x in 0..<3 {
            for y in 0..<3 {
                if grid[row + x][col + y] == num {
                    return false
                }
            }
        }
        
        return true
    }
        
    func makeMove(grid: inout Grid, row: Int, col: Int, value: Int8) {
        if grid.state != GameState.playing.rawValue { return }
        
        guard canEditCell(incomplete: grid.incomplete, row: row, col: col) else { return }
        
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
