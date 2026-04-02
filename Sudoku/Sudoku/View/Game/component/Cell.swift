//
//  Cell.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 28/03/26.
//

import SwiftUI

struct CellView: View {
    
    @EnvironmentObject var theme: ThemeManager
    
    var row: Int
    var col: Int
    var value: Int8
    var isFixed: Bool
    var wrong: Bool
    var isSelected: Bool
    var isHighlighted: Bool
    var onTap: () -> Void
    
    var body: some View {
        Text(value == 0 ? "" : "\(value)")
            .font(.title)
            .foregroundStyle(textColor)
            .frame(width: 40, height: 40)
            .background(backgroundColor)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .onTapGesture {
                onTap()
            }
    }
    
    // MARK: - Cores
    
    private var textColor: Color {
        if isFixed {
            return theme.colors.textFixed
        } else if wrong {
            return theme.colors.textWrong
        } else {
            return theme.colors.textCorrect
        }
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return theme.colors.selected.opacity(0.3)
        } else if wrong {
            return theme.colors.textWrong.opacity(0.15)
        } else if isHighlighted {
            return theme.colors.highlighted.opacity(0.2)
        } else {
            return (row / 3 + col / 3) % 2 == 0
                ? theme.colors.cellBackground
                : theme.colors.cellAltBackground
        }
    }
}

#Preview {
    CellView(row: 1, col: 1, value: 1, isFixed: true, wrong: false, isSelected: true, isHighlighted: true, onTap: {})
}
