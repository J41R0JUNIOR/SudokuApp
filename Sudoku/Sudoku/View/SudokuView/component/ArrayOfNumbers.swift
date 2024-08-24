//
//  ArrayOfFiles.swift
//  Sudoku
//
//  Created by Jairo Júnior on 23/08/24.
//

import SwiftUI
import SwiftData

struct ArrayOfNumbers: View {
    @State var array2 = [1, 3, 5, 2, 7, 8, 9, 4, 6]
    @Binding var array: [Int]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        LazyVGrid(columns: columns) {
            ForEach(array2, id: \.self) { number in
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

