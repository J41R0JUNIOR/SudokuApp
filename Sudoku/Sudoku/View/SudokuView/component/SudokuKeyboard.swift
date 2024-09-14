import SwiftUI
import SwiftData

struct SudokuKeyboard: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedNumber: Int
    @Binding var correctNumber: Int
    @Binding var maxQtd: Int
    @Binding var actualQtd: Int
    @Binding var showGameOverAlert: Bool
    @Binding var showWonAlert: Bool
    @Binding var additional: [Int]
    @Binding var restNumber: Int
    @Binding var gameState: GameState
    @Binding var howMuchNumber: [Int]
    
    //    @Binding var editMode: Bool
    @EnvironmentObject var haptics: HapticsManager
    
    var dataManager: DataManager?
    
    var frameWidth = UIScreen.main.bounds.width / 10
    var frameHeight = UIScreen.main.bounds.height / 10
    
    var body: some View {
        HStack(spacing: 10) {
            LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 10), count: 9)) {
                ForEach(1..<10) { number in
                    Button {
                        handleButtonPress(for: number)
                    } label: {
                        VStack{
                            Text("\(number)")
                                .font(.title)
                                .bold()
Spacer()
                            Text("\(howMuchNumber[number])")
                                .font(.title3)
                        }
                            .frame(width: frameWidth)
                            .background(Color.primary)
                            .foregroundStyle(.background)
                            .cornerRadius(15)
                    }
                }
            }
        }
        .onChange(of: restNumber, {
            if restNumber == 0 {
                showWonAlert = true
            }
        })
        .onAppear {
            if restNumber == 0 {
                showWonAlert = true
                gameState = .won
            }else if actualQtd == maxQtd{
                showGameOverAlert = true
                gameState = .gameOver
            }
        }
    }
    
    private func handleButtonPress(for number: Int) {
        switch gameState {
        case .playing:
            handlePlayingState(for: number)
        case .editing:
            handleEditingState(for: number)
        case .gameStopped:
            break
        case .gameOver:
            handleGameOverState()
        case .won:
            handleWonState()
        }
        haptics.callVibration()
    }
    
    private func handleGameOverState(){
        showGameOverAlert = true
    }
    
    private func handleWonState(){
        showWonAlert = true
    }
    
    private func handlePlayingState(for number: Int) {
        if selectedNumber == number {
            selectedNumber = 0
        } else if actualQtd < maxQtd || restNumber > 0 {
            selectedNumber = number
            additional = []
            
            if selectedNumber == correctNumber {
                if restNumber <= 0 {
                    handleWonState()
                } else {
                    restNumber -= 1
                }
            } else if selectedNumber != correctNumber && actualQtd < maxQtd {
                actualQtd += 1
                if actualQtd == maxQtd {
                    handleGameOverState()
                }
            }
        } else {
            handleGameOverState()
        }
    }
    
    private func handleEditingState(for number: Int) {
        if additional.contains(number) {
            additional.removeAll { $0 == number }
        } else {
            additional.append(number)
        }
    }
}

enum GameState {
    case playing
    case editing
    case gameStopped
    case gameOver
    case won
    //    case none
}

#Preview{
    SudokuKeyboard(selectedNumber: .constant(0), correctNumber: .constant(0), maxQtd: .constant(0), actualQtd: .constant(0), showGameOverAlert: .constant(false), showWonAlert: .constant(false), additional: .constant([]), restNumber: .constant(1), gameState: .constant(.playing), howMuchNumber: .constant([3]))
}
