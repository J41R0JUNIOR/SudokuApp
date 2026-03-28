//
//  Cell.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 28/03/26.
//

import SwiftUI

struct CellView: View {
    
    var row: Int
    var col: Int
    var value: Int8
    var isFixed: Bool
    var wrong: Bool
    var isSelected: Bool
    var isHighlighted: Bool
    var onTap: () -> Void
    
    var body: some View {
        Button (action: {
            onTap()
        },label:{
            ZStack{
                Rectangle()
                    .fill(backgroundColor)
                    .frame(width: 42, height: 42)
                    .overlay(
                        Rectangle()
                            .stroke(Color.primary.opacity(0.3), lineWidth: 0.2)
                    )
                    .overlay(borders)
                
                Text(value != 0 ? "\(value)" : "")
                    .font(.system(size: 20))
                    .foregroundColor(textColor)
            }
        })
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return Color.blue.opacity(0.3)
        }
        if isHighlighted {
            return Color.gray.opacity(0.15)
        }
        return Color.clear
    }
    
    private var textColor: Color {
        if wrong { return .red }
        if isFixed { return .primary }
        return .blue
    }
}

#Preview {
    CellView(row: 1, col: 1, value: 1, isFixed: true, wrong: false, isSelected: true, isHighlighted: true, onTap: {})
}
