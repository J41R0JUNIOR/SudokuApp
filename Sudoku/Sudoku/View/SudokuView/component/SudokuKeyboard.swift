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
    @Binding var showAlert: Bool
    
    @EnvironmentObject var haptics: HapticsManager
    
    var dataManager: DataManager?
    
    
    var body: some View {
        HStack(spacing: 10) {
            LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 10), count: 9)) {
                ForEach(1..<10) { number in
                    Button(action: {
                        
                        if selectedNumber == number {
                            selectedNumber = 0
                        }
                        else if actualQtd < maxQtd{
                            selectedNumber = number
                            
                            if selectedNumber != correctNumber && actualQtd < maxQtd {
                                actualQtd += 1
                            }
                        } else {
                            showAlert = true
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
        
        .padding()
    }
}

//#Preview {
//    SudokuKeyBoard(selectedNumber: .constant(0), correctNumber: .constant(1), maxQtd: .constant(3), actualQtd: .constant(2), games: GameBoard()
//}
