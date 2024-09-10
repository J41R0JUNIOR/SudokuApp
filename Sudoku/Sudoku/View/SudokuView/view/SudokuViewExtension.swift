//
//  SudokuViewExtension.swift
//  Sudoku
//
//  Created by Jairo Júnior on 10/09/24.
//

import Foundation
import SwiftUI

extension SudokuView{
    
    @ViewBuilder
    var KeyBoard: some View {
        let numberBinding = viewModel.numberToBinding(rowIndex: viewModel.model.rowIndex ?? 0, columnIndex: viewModel.model.columnIndex ?? 0, game: games.first ?? .init(), modelContext: modelContext)
        let correctNumberBinding = viewModel.correctNumberToBinding(rowIndex: viewModel.model.rowIndex ?? 0, columnIndex: viewModel.model.columnIndex ?? 0, game: games.first ?? .init())
        let maxQtdBinding = viewModel.maxQtdToBinding(game: games.first ?? .init())
        let actualQtdBinding = viewModel.actualQtdBinding(game: games.first ?? .init(), modelContext: modelContext)
        let additionalBinding = viewModel.additionalBinding(rowIndex: viewModel.model.rowIndex ?? 0, columnIndex: viewModel.model.columnIndex ?? 0, game: games.first ?? .init(), modelContext: modelContext)
        let restNumbersBinding = viewModel.restNumbersBinding(game: games.first ?? .init(), modelContext: modelContext)
        
        SudokuKeyboard(selectedNumber: numberBinding, correctNumber: correctNumberBinding, maxQtd: maxQtdBinding, actualQtd: actualQtdBinding, showGameOverAlert: $viewModel.model.showGameOverAlert, showFinishAlert: $viewModel.model.showFinishAlert, additional: additionalBinding, restNumber: restNumbersBinding, editMode: $viewModel.model.editMode)
    }
    
    @ViewBuilder
     var Grid: some View {
        ZStack {
            Grid3x3View()
            
            if let rowIndex = viewModel.model.rowIndex {
                viewModel.model.rowHilight
                    .fill(Color.gray)
                    .frame(width: viewModel.model.info.frameWidth * 9, height: viewModel.model.info.frameHeight)
                    .offset(y: CGFloat(rowIndex - 4) * viewModel.model.info.frameHeight )
            }
            if let columnIndex = viewModel.model.columnIndex {
                viewModel.model.rowHilight
                    .fill(Color.gray)
                    .frame(width: viewModel.model.info.frameWidth, height: viewModel.model.info.frameHeight * 9)
                    .offset(x: CGFloat(columnIndex - 4) * viewModel.model.info.frameHeight )
            }
            
            VStack(spacing: 0) {
                ForEach(games.first?.grid.indices ?? [].indices, id: \.self) { rowIndex in
                    HStack(spacing: 0) {
                        ForEach(games.first?.grid[rowIndex].indices ?? [].indices, id: \.self) { columnIndex in
                            if let game = games.first {
                                let numberBinding = viewModel.numberToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)
                                let correctNumberBinding = viewModel.correctNumberToBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game)
                                let additionalBinding = viewModel.additionalBinding(rowIndex: rowIndex, columnIndex: columnIndex, game: game, modelContext: modelContext)
                                let isHighlighted = rowIndex == viewModel.model.rowIndex || columnIndex == viewModel.model.columnIndex
                                
                                if game.grid[rowIndex][columnIndex] == game.gridCopy[rowIndex][columnIndex] && game.grid[rowIndex][columnIndex] != 0 {
                                    SudokuFinalNumbers(finalNumbeer: numberBinding)
                                        .frame(width: viewModel.model.info.frameWidth, height: viewModel.model.info.frameHeight)
                                        .border(Color.secondary, width: 0.25)
                                        .background(isHighlighted && viewModel.model.hilightRC ? .hilight : .clear)
                                        .onTapGesture {
                                            if rowIndex == viewModel.model.rowIndex && columnIndex == viewModel.model.columnIndex{
                                                viewModel.model.hilightRC.toggle()
                                            }else{
                                                
                                                viewModel.model.rowIndex = rowIndex
                                                viewModel.model.columnIndex = columnIndex
                                                viewModel.model.hilightRC = true
                                            }
                                        }
                                } else {
                                    SudokuNumbersComponent(number: numberBinding, correctNumber: correctNumberBinding, additional: additionalBinding)
                                        .frame(width: viewModel.model.info.frameWidth, height: viewModel.model.info.frameHeight)
                                        .border(Color.secondary, width: 0.25)
                                        .background(isHighlighted && viewModel.model.hilightRC ? .hilight : .clear)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            if rowIndex == viewModel.model.rowIndex && columnIndex == viewModel.model.columnIndex{
                                                viewModel.model.hilightRC.toggle()
                                            }else{
                                                
                                                viewModel.model.rowIndex = rowIndex
                                                viewModel.model.columnIndex = columnIndex
                                                viewModel.model.hilightRC = true
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
