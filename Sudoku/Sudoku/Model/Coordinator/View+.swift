//
//  View+.swift
//  EnumNavigatorAndSwiftData
//
//  Created by Jairo Júnior on 30/04/24.
//

import SwiftUI

extension View {
    func navigationLinkValues<D>(_ data: D.Type) -> some View where D: Hashable & View{
        NavigationStack{
          self.navigationDestination(for: data.self, destination: { $0 })
        }
    }
  
    @ViewBuilder
    func `if` <Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        }else{
            self
        }
    }
}
