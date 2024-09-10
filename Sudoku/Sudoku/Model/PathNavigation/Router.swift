import SwiftUI

@Observable
public class Router: ObservableObject {
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
