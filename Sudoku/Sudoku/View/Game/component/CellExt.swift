//
//  CellExt.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 28/03/26.
//

import SwiftUI

extension CellView {
    
    var borders: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            
            Path { path in
                
                // TOP
                if row % 3 == 0 {
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: w, y: 0))
                }
                
                // LEFT
                if col % 3 == 0 {
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 0, y: h))
                }
                
                // RIGHT
                if col == 8 {
                    path.move(to: CGPoint(x: w, y: 0))
                    path.addLine(to: CGPoint(x: w, y: h))
                }
                
                // BOTTOM
                if row == 8 {
                    path.move(to: CGPoint(x: 0, y: h))
                    path.addLine(to: CGPoint(x: w, y: h))
                }
            }
            .stroke(Color.primary, lineWidth: 2)
        }
    }
}
