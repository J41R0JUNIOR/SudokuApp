import SwiftUI

@Observable
public class Router: ObservableObject { 
    public var path = NavigationPath()
    public static var shared: Router = Router()
    
    func push(_ route: RoutePath) {
        path.append(route)
    }
    
    func push(_ view: Routes){
        path.append(RoutePath(view))
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
