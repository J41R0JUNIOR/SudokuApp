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
    @EnvironmentObject var router: Router
    
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard]
    @Bindable var viewModel = HomeViewModel()
    
    var averageFrame = UIScreen.main.bounds.width  * 0.3
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            VStack {
                
                HStack{
                    Spacer()
                    Button {
                        router.changeRoute(RoutePath(.settings))
                        
                    } label: {
                        Image(systemName: "gear").bold()
                            .foregroundStyle(.background)
                        
                    }.buttonStyle(.borderedProminent)
                        .cornerRadius(50)
                   
                }
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: averageFrame, height: averageFrame)
                
                Text("SudoKu")
                    .bold()
                    .padding()
                
                Spacer()
                
                if !games.isEmpty {
                    Button("Continue"){
                        router.changeRoute(RoutePath(.sudoku))
                    } .foregroundStyle(.background)
                    
                    Button{
                        viewModel.showAlert.toggle()
                        haptics.callVibration()
                        
                    }label: {
                        Text("New game")
                            .foregroundStyle(.background)
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
                   
                }else{
                    Button{
                        haptics.callVibration()
                        viewModel.showNewGameSheet.toggle()

                    }label: {
                        Text("New game")
                            .foregroundStyle(.background)
                    }
                }
                
                Spacer()
            }
            .navigationDestination(for: RoutePath.self) { route in
                route.findPath()
            }
            .sheet(isPresented: $viewModel.showNewGameSheet) {
                HomeSelectionMode().presentationDetents([.fraction(0.3)])
            }
            .onAppear(perform: {
                viewModel.dataManager = DataManager(modelContext: modelContext)
            })
            .tint(.primary)
            .padding()
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    return HomeView()
        .navigationLinkValues(NavigationContentViewCoordinator.self)
        .modelContainer(modelContent)
}

