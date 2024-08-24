//
//  HomeView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//
import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var haptics: HapticsManager
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard]
    @Bindable var viewModel = HomeViewModel()
    
    var frameWidth = UIScreen.main.bounds.width  * 0.3
//    var frameHeight = UIScreen.main.bounds.width  * 1
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: frameWidth, height: frameWidth)              
            
            Text("SudoKu")
                .bold()
                .padding()
            
            Spacer()
            
            if !games.isEmpty {
                NavigationLink(value: NavigationContentViewCoordinator.sudoku(selectedMode: viewModel.choice)) {
                    Text("Continue")
                        .foregroundStyle(.background)
                }
                .buttonStyle(.borderedProminent)
                
     
                Button("New game") {
                    viewModel.showAlert.toggle()
                    haptics.callVibration()
                }
             
                .alert("It'll delete your progress. \nAre you sure?", isPresented: $viewModel.showAlert) {
                    Button("Yes") {
                        haptics.callVibration()
                        viewModel.showAlert.toggle()
                        viewModel.showNewGameSheet.toggle()
                    }
                    Button("No", role: .cancel, action: {
                        haptics.callVibration()
                    })
                }
                .sheet(isPresented: $viewModel.showNewGameSheet) {
                    HomeSelectionMode().presentationDetents([.fraction(0.3)])
                }
            }else{
                NavigationModal(.sheet, value: NavigationContentViewCoordinator.homeSelectionMode, data: NavigationContentViewCoordinator.self, presentationDetents: [.fraction(0.3)]) {
                    Text("New game")
                } anyFunction: {
                    haptics.callVibration()
                }
            }
            
            Spacer()
            
        }
        .tint(.primary)
        .padding()
        .buttonStyle(.bordered)
        .onAppear(perform: {
            viewModel.dataManager = DataManager(modelContext: modelContext)
        })
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    return HomeView()
        .navigationLinkValues(NavigationContentViewCoordinator.self)
        .modelContainer(modelContent)
}
