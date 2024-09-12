//
//  Grid3x3View.swift
//  Sudoku
//
//  Created by Jairo Júnior on 10/09/24.
//

import SwiftUI

struct Grid3x3View: View {
    let rows = 3
    let columns = 3
    
    @State private var numbers: [[Int]] = [[0,0,0], [0,0,0], [0,0,0]]
    
    var averageFrame = UIScreen.main.bounds.width  * 0.3
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: averageFrame, height: averageFrame)
            
            VStack(spacing: 0) {
                ForEach(0..<rows, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<columns, id: \.self) { column in
                            ZStack{
                                Rectangle()
                                    .stroke(.background, lineWidth: 2)
                                    .frame(width: averageFrame/3, height: averageFrame/3)
                                    
                                if numbers[row][column] != 0 {
                                    Text("\(numbers[row][column])")
                                        .foregroundStyle(.background)
                                        .font(.system(size: 30, weight: .bold))
                                   
                                }else{
                                    Text(" ")
                                        .foregroundStyle(.background)
                                        .font(.system(size: 30, weight: .bold))
                                }
                               
                            }
                        }
                    }
                }
            }
            
        } .onAppear {
            numbers = generateNumbers()
        }
    
    }
    
    func generateNumbers() -> [[Int]] {
        let flatNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9].shuffled()
        
        var grid: [[Int]] = []
        for i in 0..<rows {
            let start = i * columns
            let end = start + columns
            grid.append(Array(flatNumbers[start..<end]))
        }
        
        let qtd = Int.random(in: 0...4)
        grid = removeNumbers(qtd: qtd, gridCopy: grid)
        
        return grid
    }
    
    func removeNumbers(qtd: Int, gridCopy: [[Int]]) -> [[Int]]{
        var grid = gridCopy
        var count = 0
        
        while count < qtd{
            let i = Int.random(in: 0..<3)
            let j = Int.random(in: 0..<3)
            
            if grid[i][j] != 0{
                grid[i][j] = 0
                count += 1
            }
        }
        return grid
    }
}

#Preview {
    Grid3x3View()
}
