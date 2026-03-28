//
//  Untitled.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//

protocol GridRepository {
    func create(data: Grid);
    func load() -> Grid?
    func update(data: Grid)
    func delete(id: String)
    func deleteAll()
}
