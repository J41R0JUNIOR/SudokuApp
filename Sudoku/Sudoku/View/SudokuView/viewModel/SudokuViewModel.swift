import Foundation
import SwiftUI
import SwiftData

@Observable
class SudokuViewModel {
    var model = SudokuModel()

    func correctNumberToBinding(rowIndex: Int, columnIndex: Int, game: GameBoard) -> Binding<Int> {
        let correctNumberBinding = Binding<Int>(
            get: {
                guard rowIndex >= 0, rowIndex < game.solution.count,
                      columnIndex >= 0, columnIndex < game.solution[rowIndex].count else {
                    return 0
                }
                return game.solution[rowIndex][columnIndex]
            },
            set: { _ in }
        )
        return correctNumberBinding
    }

    func numberToBinding(rowIndex: Int, columnIndex: Int, game: GameBoard, modelContext: ModelContext) -> Binding<Int> {
        let numberBinding = Binding<Int>(
            get: {
                guard rowIndex >= 0, rowIndex < game.grid.count,
                      columnIndex >= 0, columnIndex < game.grid[rowIndex].count else {
                    return 0
                }
                return game.grid[rowIndex][columnIndex]
            },
            set: { newValue in
                guard rowIndex >= 0, rowIndex < game.grid.count,
                      columnIndex >= 0, columnIndex < game.grid[rowIndex].count else {
                    return
                }
                game.grid[rowIndex][columnIndex] = newValue
                try? modelContext.save()
            }
        )
        return numberBinding
    }

    func maxQtdToBinding(game: GameBoard) -> Binding<Int> {
        let maxQtdBinding = Binding<Int>(
            get: { game.maxQtd },
            set: { _ in }
        )
        return maxQtdBinding
    }

    func actualQtdBinding(game: GameBoard, modelContext: ModelContext) -> Binding<Int> {
        let actualQtdBinding = Binding<Int>(
            get: { game.actualQtd },
            set: { newValue in
                game.actualQtd = newValue
                try? modelContext.save()
            }
        )
        return actualQtdBinding
    }

    func additionalBinding(rowIndex: Int, columnIndex: Int, game: GameBoard, modelContext: ModelContext) -> Binding<[Int]> {
        let additionalBinding = Binding<[Int]>(
            get: {
                guard rowIndex >= 0, rowIndex < game.additional.count,
                      columnIndex >= 0, columnIndex < game.additional[rowIndex].count else {
                    return []
                }
                return game.additional[rowIndex][columnIndex]
            },
            set: { newValue in
                guard rowIndex >= 0, rowIndex < game.additional.count,
                      columnIndex >= 0, columnIndex < game.additional[rowIndex].count else {
                    return
                }
                game.additional[rowIndex][columnIndex] = newValue
                try? modelContext.save()
            }
        )
        return additionalBinding
    }
}
