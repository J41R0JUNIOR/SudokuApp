import Foundation
import SwiftUI


enum Routes {
    case home
    case sudoku
    case settings
    case none
}

extension Routes: Equatable, Hashable{
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


@Observable
public class Router: ObservableObject {
    public var path = NavigationPath()
    public static var shared: Router = Router()
    
    public func changeRoute(_ route: RoutePath) {
        path.append(route)
        print("path",path)
        print("route",route.route)
    }
    
    public func backRoute() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}