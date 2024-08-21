//
//  Info.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import Foundation

class BringInfo: Codable, ObservableObject {
    let game: String
    let info: String
    let data: [[Int]]
    let easy: [[Int]]
    let medium: [[Int]]
    let hard: [[Int]]
}


enum ApiError: Error{
    case invalidUrl
    case invalidResponse
    case invalidData
}

enum GameSelectionMode{
    case easy
    case medium
    case hard
}
