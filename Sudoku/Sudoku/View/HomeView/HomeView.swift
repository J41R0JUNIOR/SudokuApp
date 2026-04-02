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
    @EnvironmentObject var theme: ThemeManager
    
    @State private var viewModel: HomeViewModel?
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack{
                theme.colors.background
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            router.push(.settings)
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundStyle(theme.colors.primary)
                        }
                        .buttonStyle(.plain)
                    }
                                        
                    Grid3x3View()
                    
                    Spacer()
                    
                    if let vm = viewModel {
                        if vm.grid != nil {
                            
                            Button("Continue") {
                                if let grid = vm.grid{
                                    router.push(.sudoku(grid: grid))
                                }
                            }
                            .foregroundStyle(theme.colors.textSecondary)
                            .tint(theme.colors.primary)
                            
                            Button {
                                haptics.callVibration()
                                vm.showAlert.toggle()
                            } label: {
                                Text("New game")
                                    .foregroundStyle(theme.colors.textSecondary)
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
                                    .foregroundStyle(theme.colors.textSecondary)
                            }
                            .tint(theme.colors.primary)
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
                            .presentationDetents([.fraction(0.5)])
                    }
                }
                .padding()
                .tint(.primary)
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    private func setup() {
        if viewModel == nil {
            let repository = SD_Grid_Repository(modelContext: context)
            let vm = HomeViewModel(repository: repository)
            viewModel = vm
        }
        
        if let vm = viewModel {
            vm.loadLastGame()
        }
    }
}

#Preview {
    let modelContainer: ModelContainer = .appContainer
    let haptics = HapticsManager()
    let router = Router()
    let theme = ThemeManager()

    return HomeView()
        .modelContainer(modelContainer)
        .environmentObject(haptics)
        .environmentObject(router)
        .environmentObject(theme)
}
