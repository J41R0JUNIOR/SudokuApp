//
//  SudokuKeyBoard.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI

struct SudokuKeyBoard: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedNumber: Int
    
    var body: some View {
        HStack(spacing: 10) {
            LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 10), count: 9)) {
                ForEach(1..<10) { number in
                    Button(action: {
                        selectedNumber = number
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("\(number)")
                            .font(.title)
                            .frame(width: UIScreen.main.bounds.width / 10, height: 50)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    SudokuKeyBoard(selectedNumber: .constant(0))
}
