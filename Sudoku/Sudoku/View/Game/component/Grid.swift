//
//  Grid.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 28/03/26.
//

import SwiftUI

struct Indice: Equatable {
    var row: Int
    var col: Int
}

struct GridView: View {
    @EnvironmentObject var theme: ThemeManager
    
    var gameGrids: Grid
    var selectedCell: Indice?
    var onSelectCell: ((Indice) -> Void)?
    let engine = Engine.shared
    
    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<9, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<9, id: \.self) { col in
                        
                        let value = engine.getCellValue(
                            incomplete: gameGrids.incomplete,
                            userGrid: gameGrids.userGrid,
                            row: row,
                            col: col
                        )
                        
                        let wrong = engine.isWrong(
                            userGrid: gameGrids.userGrid,
                            complete: gameGrids.complete,
                            row: row,
                            col: col
                        )
                        
                        let isFixed = !engine.canEditCell(
                            incomplete: gameGrids.incomplete,
                            row: row,
                            col: col
                        )
                        
                        let isSelected = selectedCell == Indice(row: row, col: col)
                        let isSameRow = selectedCell?.row == row
                        let isSameCol = selectedCell?.col == col
                        let isHighlighted = isSameRow || isSameCol
                        
                        Text(value == 0 ? "" : "\(value)")
                            .font(.title)
                            .foregroundStyle(
                                   isFixed  ? theme.colors.textFixed :
                                   wrong ? theme.colors.textWrong : theme.colors.textCorrect
                               )
                            .frame(width: 40, height: 40)
                            .background(
                                Group {
                                    if isSelected {
                                        theme.colors.selected.opacity(0.3)
                                    } else if wrong {
                                        theme.colors.textWrong.opacity(0.15)
                                    } else if isHighlighted {
                                        theme.colors.highlighted.opacity(0.2)
                                    } else {
                                        (row / 3 + col / 3) % 2 == 0
                                            ? theme.colors.cellBackground
                                            : theme.colors.cellAltBackground
                                    }
                                }
                            )
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                            .onTapGesture {
                                onSelectCell?(Indice(row: row, col: col))
                            }
                    }
                }
            }
        }
        .padding(4)
        .background(theme.colors.background)
        .cornerRadius(12)
//        .shadow(color: theme.colors.primary.opacity(0.3), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    let theme = ThemeManager()
    let g = Grid(
        id: "1",
        mistakes:0,
        state: GameState.playing.rawValue,
        
        incomplete: [
            [5,3,0, 0,7,0, 0,0,0],
            [6,0,0, 1,9,5, 0,0,0],
            [0,9,8, 0,0,0, 0,6,0],

            [8,0,0, 0,6,0, 0,0,3],
            [4,0,0, 8,0,3, 0,0,1],
            [7,0,0, 0,2,0, 0,0,6],

            [0,6,0, 0,0,0, 2,8,0],
            [0,0,0, 4,1,9, 0,0,5],
            [0,0,0, 0,8,0, 0,7,9]
        ],
        
        complete: [
            [5,3,4, 6,7,8, 9,1,2],
            [6,7,2, 1,9,5, 3,4,8],
            [1,9,8, 3,4,2, 5,6,7],

            [8,5,9, 7,6,1, 4,2,3],
            [4,2,6, 8,5,3, 7,9,1],
            [7,1,3, 9,2,4, 8,5,6],

            [9,6,1, 5,3,7, 2,8,4],
            [2,8,7, 4,1,9, 6,3,5],
            [3,4,5, 2,8,6, 1,7,9]
        ],
        
        userGrid: [
            [5,3,0, 6,7,7, 9,1,2],
            [6,7,2, 1,9,5, 3,4,8],
            [1,9,8, 3,4,2, 5,6,7],

            [8,5,9, 7,6,1, 4,2,3],
            [4,2,6, 8,5,3, 7,9,1],
            [7,1,3, 9,2,4, 8,5,6],

            [9,6,1, 5,3,7, 2,8,4],
            [2,8,7, 4,1,9, 0,0,5],
            
            [3,4,5, 3,8,5, 1,7,1]
        ]
    )
    
    GridView(
        gameGrids: g,
        selectedCell: .init(row: 8, col: 8),
        onSelectCell: { _ in }
    )
    .environmentObject(theme)
}
