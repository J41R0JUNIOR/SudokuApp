//
//  Untitled.swift
//  Sudoku
//
//  Created by The Godfather Júnior on 27/03/26.
//

import SwiftUI

struct HomeSelectionMode: View {
    @EnvironmentObject var haptics: HapticsManager
    @EnvironmentObject var router: Router
    @EnvironmentObject var engine: Engine
    let repository: GridRepository
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.modelContext) var modelContext

    
    
    var body: some View {
        VStack{
            ForEach(GameSelectionMode.allCases, id: \.self){ mode in
                Button(action: {
                    buttonAction(mode: mode)
                    }, label: {
                        Text(mode.rawValue)
                            .bold()
                            .foregroundStyle(.background)
                    })
            }
        }
    }
    
    func buttonAction(mode: GameSelectionMode){
            haptics.callVibration()
            
            let grid = engine.generateGrid(mode: mode)
            
            repository.deleteAll()
            repository.create(data: grid)
            presentationMode.wrappedValue.dismiss()
            
            router.push(.sudoku)
    }
}

//#Preview {
//    let content = 
//    let context =
//    HomeSelectionMode(repository: SD_Grid_Repository(modelContext: <#T##ModelContext#>))
//}
