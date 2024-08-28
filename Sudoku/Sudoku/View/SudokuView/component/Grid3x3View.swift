//
//  Grid.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import SwiftUI

struct Grid3x3View: View {
    var info: InfoData = .init()
    let rows = 3
    let columns = 3
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<columns, id: \.self) { column in
                        Rectangle()
                            .stroke(Color.primary, lineWidth: 1) 
                            .frame(width: info.bigGridFrame, height: info.bigGridFrame)
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
