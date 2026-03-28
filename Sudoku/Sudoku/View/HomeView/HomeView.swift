//
//  HomeView.swift
//  Sudoku
//
//  Created by Jairo Júnior on 20/08/24.
//
import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var haptics: HapticsManager
    @EnvironmentObject var router: Router
    @EnvironmentObject var engine: Engine
    
    @State private var viewModel: HomeViewModel?
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                
                HStack {
                    Spacer()
                    
                    Button {
                        router.push(.settings)
                    } label: {
                        Image(systemName: "gear")
                            .font(.system(size: 25, weight: .bold))
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
                
                if let vm = viewModel {
                    
                    if vm.grid != nil {
                        
                        Button("Continue") {
                            router.push(.sudoku)
                        }
                        .foregroundStyle(.background)
                        
                        Button {
                            haptics.callVibration()
                            vm.showAlert.toggle()
                        } label: {
                            Text("New game")
                                .foregroundStyle(.background)
                        }
                        .alert(
                            "It'll delete your progress.\nAre you sure?",
                            isPresented: Binding(
                                get: { vm.showAlert },
                                set: { vm.showAlert = $0 }
                            )
                        ) {
                            Button("Yes") {
                                haptics.callVibration()
                                vm.showAlert = false
                                vm.showNewGameSheet = true
                            }
                            
                            Button("No", role: .cancel) {
                                haptics.callVibration()
                            }
                        }
                        
                    } else {
                        Button {
                            haptics.callVibration()
                            vm.showNewGameSheet = true
                        } label: {
                            Text("New game")
                                .foregroundStyle(.background)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationDestination(for: Routes.self) { route in
                route
            }
            .onAppear {
                
                setup()
            }
            .sheet(
                isPresented: Binding(
                    get: { viewModel?.showNewGameSheet ?? false },
                    set: { viewModel?.showNewGameSheet = $0 }
                )
            ) {
                if let vm = viewModel {
                    HomeSelectionMode(repository: vm.repository)
                        .presentationDetents([.fraction(0.3)])
                    
                }
            }
            .padding()
            .tint(.primary)
            .buttonStyle(.borderedProminent)
        }
    }
    
    private func setup() {
        if viewModel == nil {
            let repository = SD_Grid_Repository(modelContext: context)
            let vm = HomeViewModel(repository: repository)
            vm.loadLastGame()
            viewModel = vm
        }
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    
    let haptics = HapticsManager()
    let router = Router()
    let theme = ThemeManager()
    let engine = Engine()
    
    return HomeView()
        .modelContainer(modelContainer)
        .environmentObject(haptics)
        .environmentObject(router)
        .environmentObject(theme)
        .environmentObject(engine)
}
