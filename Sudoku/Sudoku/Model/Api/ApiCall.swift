//
//  ApiCall.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import Foundation

struct SudokuGridGame{
    var grid: [[Int]]
    var solution: [[Int]]
}

@Observable
class ApiCall{
     var sudoku: BringInfo?
     var gameGrid: [[Int]] = [[]]
     var solutionGrid: [[Int]] = [[]]    
    
//    @StateObject var model = HomeScreenM()

    func newGame(mode: GameSelectionMode) async {
        do {
            sudoku = try await newBoard()
            switch mode {
            case .easy:
                gameGrid = sudoku?.easy ?? [[]]
            case .medium:
                gameGrid = sudoku?.medium ?? [[]]
            case .hard:
                gameGrid = sudoku?.hard ?? [[]]
            }
           
            solutionGrid = sudoku?.data ?? [[]]
            
        } catch ApiError.invalidUrl {
            print("Invalid URL")
        } catch ApiError.invalidResponse {
            print("Invalid Response")
        } catch ApiError.invalidData {
            print("Invalid Data")
        } catch {
            print("Unexpected error")
        }
    }


    func newBoard() async throws -> BringInfo {
//        let endpoint = "https://sudoku-api.vercel.app/api/dosuku"
        let endpoint = "https://sudoku-game-and-api.netlify.app/api/sudoku"

        guard let url = URL(string: endpoint) else {
            throw ApiError.invalidUrl
        }
     

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ApiError.invalidResponse
        }
       
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let bringInfo = try decoder.decode(BringInfo.self, from: data)
            return bringInfo
        } catch {
            print("Error decoding: \(error)")
            throw ApiError.invalidData
        }
    }
}

