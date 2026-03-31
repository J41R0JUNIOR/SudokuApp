import Foundation
import SwiftData
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
            GameView()
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
