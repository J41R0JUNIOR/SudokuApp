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
    @Binding var showGameOverAlert: Bool
    @Binding var showFinishAlert: Bool
    @Binding var additional: [Int]
    @Binding var restNumber: Int
    
    @Binding var editMode: Bool
    @EnvironmentObject var haptics: HapticsManager
    
    var dataManager: DataManager?
    
    var frameWidth = UIScreen.main.bounds.width / 10
    var frameHeight = UIScreen.main.bounds.width / 10
    
    
    var body: some View {
        HStack(spacing: 10) {
            LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 10), count: 9)) {
                ForEach(1..<10) { number in
                    Button {
                        
                        if !editMode{
                            
                            if selectedNumber == number {
                                selectedNumber = 0
                            }
                            else if actualQtd < maxQtd {
                                selectedNumber = number
                                additional = []
                                
                                if selectedNumber == correctNumber{
                                    
                                    if restNumber <= 0{
                                        showFinishAlert = true
                                    }else{
                                        restNumber -= 1
                                    }
                                }
                                
                                if selectedNumber != correctNumber && actualQtd < maxQtd {
                                    actualQtd += 1
                                    
                                    if actualQtd == maxQtd{
                                        showGameOverAlert = true
                                    }
                                }
                            }
                            else {
                                showGameOverAlert = true
                            }
                        }else{
                            if additional.contains(number){
                                additional.removeAll { n in
                                    n == number
                                }
                            }else{
                                additional.append(number)
                            }
                        }
                        
                        haptics.callVibration()
                        
                    } label: {
                        Text("\(number)")
                            .font(.title)
                            .frame(width: frameWidth, height: frameHeight)
                            .background(Color.primary)
                            .clipShape(RoundedRectangle(cornerSize: .init(width: frameWidth, height: frameHeight), style: .circular))
                            .foregroundStyle(.background)
                    }
                }
            }
        }.onAppear {
            if restNumber == 0{
               showFinishAlert = true
           }
        }
    }
}

