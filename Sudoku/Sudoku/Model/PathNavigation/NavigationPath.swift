//
//  NavigationPath.swift
//  Sudoku
//
//  Created by Jairo Júnior on 09/09/24.
//

import Foundation
import SwiftUI

public enum Routes {
    case first, second
    case none
}

extension Routes: Equatable {
    public static func == (lhs: Routes, rhs: Routes) -> Bool {
        switch (lhs, rhs) {
        case (.first, .first),
             (.second, .second),
             (.none, .none):
            return true
        default:
            return false
        }
    }
}

public struct RoutePath: Hashable {
    public var route: Routes = .none
    public init(_ route: Routes) {
        self.route = route
    }
}

public class Router: ObservableObject {
    @Published public var path = NavigationPath()
    
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
