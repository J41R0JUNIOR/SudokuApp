//
//  GameKeyboard.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//

import SwiftUI

struct GameKeyboardView: View {
    @EnvironmentObject var theme: ThemeManager

    let onInput: (Int8?) -> Void
        
    var body: some View {
        VStack(spacing: 15) {
            
            Button(action: {
                onInput(nil)
            }) {
                Text("⌫")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(theme.colors.textPrimary)
                    .foregroundColor(theme.colors.cellBackground)
                    .clipShape(Capsule())
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 10, ), count: 9)) {
                ForEach(1...9, id: \.self) { num in
                    Button(action: {
                        onInput(Int8(num))
                    }) {
                        Text("\(num)")
                            .font(.title.bold())
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(theme.colors.cellBackground)
                            .foregroundColor(theme.colors.textPrimary)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(theme.colors.background.opacity(0.95))
        .cornerRadius(20)
    }
}

#Preview {
    var theme = ThemeManager()
    GameKeyboardView(onInput: { _ in })
        .environmentObject(theme)
}
