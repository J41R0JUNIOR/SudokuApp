//
//  CellState.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 01/04/26.
//

struct CellState: Equatable {
    let value: Int8
    let wrong: Bool
    let isFixed: Bool
}
