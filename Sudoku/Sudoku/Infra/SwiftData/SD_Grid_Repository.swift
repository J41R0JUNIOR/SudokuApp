//
//  DataManager.swift
//  Sudoku
//
//  Created by Jairo Júnior on 21/08/24.
//

import Foundation
import SwiftData

@Observable
class SD_Grid_Repository: GridRepository {

    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func load() -> Grid? {
        let descriptor = FetchDescriptor<SD_Grid_Model>()
        return try? modelContext.fetch(descriptor).first?.toDomain()
    }
    
    func create(data: Grid) {
        self.deleteAll()
        
        let grid = SD_Grid_Model(data: data)
        modelContext.insert(grid)
        
        do {
            try modelContext.save()
        } catch {
            print("Erro ao salvar:", error)
        }
    }
    
    func update(data: Grid) {
        let id = data.id 
        
        let descriptor = FetchDescriptor<SD_Grid_Model>(
            predicate: #Predicate { $0.id == id }
        )
        
        if let grid = try? modelContext.fetch(descriptor).first {
            grid.incomplete = data.incomplete
            grid.complete = data.complete
            grid.userGrid = data.userGrid
            
            try? modelContext.save()
        }
    }
    
    func delete(id: String) {
        let descriptor = FetchDescriptor<SD_Grid_Model>(
            predicate: #Predicate { $0.id == id }
        )
        
        if let grid = try? modelContext.fetch(descriptor).first {
            modelContext.delete(grid)
            try? modelContext.save()
        }
    }
    
    func deleteAll() {
        do {
            try modelContext.delete(model: SD_Grid_Model.self)
            try modelContext.save()
        } catch {
            print("Erro ao deletar todos os grids:", error)
        }
    }
}
