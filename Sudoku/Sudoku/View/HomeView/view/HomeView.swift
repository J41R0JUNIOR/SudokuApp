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
    
    var info: InfoData = .init()

    
    @Query(sort: [SortDescriptor(\GameBoard.mode, order: .reverse)]) var games: [GameBoard]
    @Bindable var viewModel = HomeViewModel()
    
    var averageFrame = UIScreen.main.bounds.width  * 0.3
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            VStack {
                HStack{
                    Spacer()
                    
                    Button {
                        router.push(.settings)
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(.foreground)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.clear)
                   
                }
                Spacer()
                
                Grid3x3View()
                
                Text("SudoKu")
                    .bold()
                    .padding()
                
                Spacer()
                
                if !games.isEmpty {
                    Button("Continue"){
                        router.push(.sudoku)
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
            .navigationDestination(for: Routes.self) { route in
                route
            }
            .sheet(isPresented: $viewModel.showNewGameSheet) {
                HomeSelectionMode().presentationDetents([.fraction(0.3)])
            }
            .onAppear(perform: {
                viewModel.dataManager = DataManager(modelContext: modelContext)
            })
            .padding()
            .tint(.primary)
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    let haptics = HapticsManager()
    let router = Router()
    return HomeView()
        .modelContainer(modelContent)
        .environmentObject(haptics)
        .environmentObject(router)
}

