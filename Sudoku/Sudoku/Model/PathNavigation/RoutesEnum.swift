import Foundation
import SwiftUI

enum Routes: View {
    
    case home
    case sudoku
    case settings
    case none
    
    var body: some View {
        switch self {
        case .home:
            HomeView()
        case .sudoku:
            SudokuView()
        case .settings:
            SettingsView()
        case .none:
            EmptyView()
        }
    }
   
}

extension Routes: Equatable, Hashable, Identifiable {
    var id: UUID {
        .init()
    }
    
//    var body: some View { view }
    
    static func == (lhs: Routes, rhs: Routes) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        
        switch self {
        default:
            hasher.combine("\(self)")
        }
    }
}
