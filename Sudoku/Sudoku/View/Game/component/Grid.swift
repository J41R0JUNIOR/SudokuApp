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
    
    var gameGrids: Grid
    var selectedCell: Indice?
    var onSelectCell: ((Indice) -> Void)?
    
    private let engine = Engine.shared
    
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
                        
                        let isFixed = !engine.canEditCell(
                            incomplete: gameGrids.incomplete,
                            row: row,
                            col: col
                        )
                        
                        let wrong = engine.isWrong(
                            userGrid: gameGrids.userGrid,
                            complete: gameGrids.complete,
                            row: row,
                            col: col
                        )
                        
                        let isSelected = selectedCell == Indice(row: row, col: col)
                        let isSameRow = selectedCell?.row == row
                        let isSameCol = selectedCell?.col == col
                        let isHighlighted = isSameRow || isSameCol
                        
                        Text(value == 0 ? "" : "\(value)")
                            .font(.title2)
                            .frame(width: 40, height: 40)
                            .background(
                                Group {
                                    if isSelected {
                                        Color.blue.opacity(0.3)
                                    } else if isHighlighted {
                                        Color.blue.opacity(0.1)
                                    } else {
                                        // Xadrez 3x3: blocos alternados
                                        (row / 3 + col / 3) % 2 == 0
                                            ? Color.white
                                            : Color.gray.opacity(0.1)
                                    }
                                }
                            )
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(isFixed ? Color.gray.opacity(0.9) : Color.gray.opacity(0.4), lineWidth: 1)
                            )
                            .onTapGesture {
                                onSelectCell?(Indice(row: row, col: col))
                            }
                    }
                }
            }
        }
        .padding(4)
        .background(Color(white: 0.95))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    let g: Grid = Grid(id: "1", incomplete: [[1,1,0,0,0,0,0,0,0],[1,1,0,1,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0]], complete: [[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0]], userGrid: [[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0],[1,1,0,0,0,0,0,0,0]])
    
    GridView(gameGrids: g, selectedCell: .init(row: 3, col: 3), onSelectCell: {_ in})
}
