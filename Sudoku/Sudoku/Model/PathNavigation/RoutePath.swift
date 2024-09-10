import SwiftUI

public struct RoutePath: Hashable {
    var route: Routes
    
     init(_ route: Routes) {
        self.route = route
    }
    
    @ViewBuilder
    func findPath() -> some View {
        switch route {
        case .home:
            HomeView()
        case .sudoku:
            SudokuView()
        case .none:
            EmptyView()
        case .settings:
            SettingsView()
        }
    }
}


