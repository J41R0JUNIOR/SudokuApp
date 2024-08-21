//
//  Grid.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import SwiftUI

struct Grid3x3View: View {
    var frameWidth = (UIScreen.main.bounds.width / 3) * 0.95
    var frameHeight = (UIScreen.main.bounds.width / 3) * 1
    let rows = 3
    let columns = 3
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<columns, id: \.self) { column in
                        Rectangle()
                            .stroke(Color.primary, lineWidth: 1) // Desenha a borda com a cor e largura desejada
                            .frame(width: frameWidth, height: frameHeight)
                    }
                }
            }
        }
    }
}

struct Grid3x3View_Previews: PreviewProvider {
    static var previews: some View {
        Grid3x3View()
    }
}
