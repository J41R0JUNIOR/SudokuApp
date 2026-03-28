//
//  GameKeyboard.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//

import SwiftUI

struct GameKeyboardView: View {
    
    let onInput: (Int8?) -> Void
    
    // Cores
    private let numberColor = Color.black.opacity(1.0)
    private let deleteColor = Color.black.opacity(1.0)
    private let textColor = Color.white
    
    var body: some View {
        VStack(spacing: 15) {
            
            // Botão de apagar
            Button(action: {
                onInput(nil)
            }) {
                Text("⌫")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(deleteColor)
                    .foregroundColor(textColor)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 2, y: 2)
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
                            .background(numberColor)
                            .foregroundColor(textColor)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.2), radius: 3, x: 2, y: 2)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(UIColor.systemBackground).opacity(0.95))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}


#Preview {
    GameKeyboardView(onInput: { _ in })
}
