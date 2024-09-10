import Foundation

enum Routes { 
    case home
    case sudoku
    case settings
    case none
}

extension Routes: Equatable, Hashable {
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
