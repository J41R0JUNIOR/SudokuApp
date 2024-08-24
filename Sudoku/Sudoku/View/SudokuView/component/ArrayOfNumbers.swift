//
//  ArrayOfFiles.swift
//  Sudoku
//
//  Created by Jairo Júnior on 23/08/24.
//

import SwiftUI
import SwiftData

struct ArrayOfNumbers: View {
    @Binding var array: [Int]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        LazyVGrid(columns: columns) {
            ForEach(array, id: \.self) { number in
                Text("\(number)")
                    .font(.system(size: 10))
                    .foregroundStyle(.primary)
            }
        }
    }
}

//#Preview {
//    ArrayOfNumbers()
//}

#Preview {
    let modelContent: ModelContainer = .appContainer
    let themeManager = ThemeManager()
    let hapticsManager = HapticsManager()
    return SudokuView(selectedMode: .medium).modelContainer(modelContent)
        .environmentObject(themeManager)
        .environmentObject(hapticsManager)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
}

