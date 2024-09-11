//
//  ModelContainerExtension.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation
import SwiftData

extension ModelContainer{
    static let appContainer: ModelContainer = {
        do{
            let container = try ModelContainer(for: GameBoard.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            return container
        }catch{
            fatalError("Failed to create appcontainer")
        }
    }()
}
