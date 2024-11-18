import SwiftUI

@Observable
public class Router: ObservableObject { 
     var path: [Routes] = []
    public static var shared: Router = Router()
    
    func push(_ route: Routes) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
