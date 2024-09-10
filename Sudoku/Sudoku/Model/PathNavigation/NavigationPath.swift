import Foundation
import SwiftUI

public enum Routes {
    case first, second
    case none
}

extension Routes: Equatable {
    public static func == (lhs: Routes, rhs: Routes) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public struct RoutePath: Hashable {
    public var route: Routes = .none
    public init(_ route: Routes) {
        self.route = route
    }
    
    @ViewBuilder
    func findPath() -> some View {
        switch route {
        case .first:
            HomeView()
        case .second:
            Text("Second View content here")
        case .none:
            Text("None")
        }
    }
}

@Observable
public class Router {
    public var path = NavigationPath()
    public static var shared: Router = Router()
    
    public func changeRoute(_ route: RoutePath) {
        path.append(route)
    }
    
    public func backRoute() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
