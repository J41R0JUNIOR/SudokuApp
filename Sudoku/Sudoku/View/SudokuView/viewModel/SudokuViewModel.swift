import Foundation
import SwiftUI
import SwiftData

@MainActor
@Observable class SudokuViewModel {
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
    
    func restNumbersBinding(game: GameBoard, modelContext: ModelContext) -> Binding<Int> {
        let restNumbersBinding = Binding<Int>(
            get: { game.restNumbers },
            set: { newValue in
                game.restNumbers = newValue
                try? modelContext.save()
            }
        )
        return restNumbersBinding
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
    
    @ViewBuilder
    func cellView(rowIndex: Int, columnIndex: Int, game: GameBoard, modelContext: ModelContext) -> any View {
        // Criação dos bindings
        let numberBinding = numberToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)
        let correctNumberBinding = correctNumberToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game)
        let additionalBinding = additionalBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)

       

        // Retorna a View correta com base nos valores
        if game.grid[rowIndex][columnIndex] == game.gridCopy[rowIndex][columnIndex] && game.grid[rowIndex][columnIndex] != 0 {
             SudokuFinalNumbers(finalNumbeer: numberBinding)
        } else {
             SudokuNumbersComponent(number: numberBinding, correctNumber: correctNumberBinding, additional: additionalBinding)
        }
    }

}
