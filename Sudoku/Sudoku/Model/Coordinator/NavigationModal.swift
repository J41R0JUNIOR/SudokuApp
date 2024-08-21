//
//  NavigationModal.swift
//  EnumNavigator
//
//  Created by Jairo Júnior on 26/04/24.
//

import SwiftUI
import SwiftData

enum NavigationModalType {
    case sheet, fullScreenCover
}

struct NavigationModal<Value: View, Label: View, D: Hashable & View>: View {
    
    @State private var isPresented = false
    
    var type: NavigationModalType
    var value: Value
    let data: D.Type
    var presentationDetents: Set<PresentationDetent>?
    var onDismiss: (() -> Void)?
    var asyncFunction: () async -> Any 
    @ViewBuilder var label: () -> Label
    
    init(_ type: NavigationModalType,
         value: Value,
         data: D.Type,
         presentationDetents: Set<PresentationDetent>? = nil,
         onDismiss: (() -> Void)? = nil,
         @ViewBuilder label: @escaping () -> Label,
         asyncFunction: @escaping () async -> Any) { // Adiciona a função assíncrona
        self.type = type
        self.value = value
        self.data = data
        self.presentationDetents = presentationDetents
        self.onDismiss = onDismiss
        self.asyncFunction = asyncFunction
        self.label = label
    }
    
    var body: some View {
        Button(action: {
            Task {
                await asyncFunction() // Chama a função assíncrona
            }
            isPresented.toggle()
        }, label: {
            label()
        })
        .if(type == .sheet) { view in
            view
                .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
                    NavigationStack {
                        value
                            .navigationLinkValues(data)
                    }
                    .presentationDetents(presentationDetents ?? [])
                }
        }
        .if(type == .fullScreenCover) { view in
            view
                .fullScreenCover(isPresented: $isPresented, onDismiss: onDismiss) {
                    NavigationStack {
                        value
                            .navigationLinkValues(data)
                    }
                }
        }
    }
}
