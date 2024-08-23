//
//  SudokuKeyBoard.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//

import SwiftUI
import SwiftData

struct SudokuKeyboard: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedNumber: Int
    @Binding var correctNumber: Int
    @Binding var maxQtd: Int
    @Binding var actualQtd: Int

    @EnvironmentObject var haptics: HapticsManager
    
    var dataManager: DataManager?
    
    @State var showAlert = false
    
    var body: some View {
        HStack(spacing: 10) {
            LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 10), count: 9)) {
                ForEach(1..<10) { number in
                    Button(action: {
                        if selectedNumber == number {
                            selectedNumber = 0
                        } else {
                            selectedNumber = number
                            
                            if selectedNumber != correctNumber {
                                if actualQtd < maxQtd {
                                    actualQtd += 1
                                } else {
                                    showAlert = true
                                }
                            }
                        }

                        haptics.callVibration()
                        
                    }) {
                        Text("\(number)")
                            .font(.title)
                            .frame(width: UIScreen.main.bounds.width / 10, height: 50)
                            .background(Color.gray.opacity(0.5))
                            .clipShape(Circle())
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .alert("You lost the game", isPresented: $showAlert) {
            Button("Aceitar"){}
            Button("Fechar", role: .cancel) {}
        }
        .padding()
    }
}

//#Preview {
//    SudokuKeyBoard(selectedNumber: .constant(0), correctNumber: .constant(1), maxQtd: .constant(3), actualQtd: .constant(2), games: GameBoard()
//}
