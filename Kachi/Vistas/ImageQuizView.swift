import SwiftUI
import Combine

struct QuizQuestion {
    let emoji: String
    let options: [String]
    let correctAnswer: String
}

struct ImageQuizView: View {
    @State private var score = 0
    @State private var currentQuestionIndex = 0
    @State private var showAnswerAlert = false
    @State private var answerCorrect = false
    @State private var timeRemaining: Double = 10.0
    @State private var totalTime: Double = 10.0
    @State private var timerActive: Bool = false
    @State private var timer: AnyCancellable?
    @State private var showRulesModal: Bool = true
    @State private var showTimeUpModal: Bool = false // Mostrar cuando el tiempo se acaba

    // Definir las preguntas y opciones en náhuatl
    let questions: [QuizQuestion] = [
        QuizQuestion(emoji: "🌞", options: ["Tōnatiuh", "Mēztli", "Citlālin"], correctAnswer: "Tōnatiuh"),
        QuizQuestion(emoji: "🌙", options: ["Ehecatl", "Tōnatiuh", "Mēztli"], correctAnswer: "Mēztli"),
        QuizQuestion(emoji: "⭐️", options: ["Citlālin", "Tōnatiuh", "Ehecatl"], correctAnswer: "Citlālin"),
        QuizQuestion(emoji: "☁️", options: ["Quiahuitl", "Miyotl", "Ehecatl"], correctAnswer: "Miyotl")
    ]

    var body: some View {
        VStack {
            Spacer()
            
            ProgressBar(progress: CGFloat(timeRemaining / totalTime), animationDuration: 0.05)
                .frame(height: 20)
                .padding()
            
            Spacer()
            
            Text("Puntuación: \(score)")
                .font(.headline)
                .padding()

            // Mostrar el emoji de la pregunta actual
            Text(questions[currentQuestionIndex].emoji)
                .font(.system(size: 100))
                .padding()
            
            Spacer()

            // Mostrar las opciones como botones
            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    checkAnswer(option)
                }) {
                    Text(option)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.azulMexicano)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }

            Spacer()
        }
        .onDisappear {
            timer?.cancel()
        }
        .sheet(isPresented: $showRulesModal) {
            GameRulesQuizView(timeLimit: totalTime) {
                showRulesModal = false
                startTimer() // Iniciar el temporizador cuando el usuario da clic en "¡Entendido!"
            }
        }
        .alert(isPresented: $showAnswerAlert) {
            Alert(
                title: Text(answerCorrect ? "¡Correcto!" : "Incorrecto"),
                message: Text(answerCorrect ? "¡Yuh mōcihuā!" : "La respuesta correcta es \(questions[currentQuestionIndex].correctAnswer)."),
                dismissButton: .default(Text("Siguiente"), action: nextQuestion)
            )
        }
        .sheet(isPresented: $showTimeUpModal, content: {
            TimeUpView(score: score, onRetry: resetGame, onReturnToHome: returnToHome)
        })
    }
    
    func checkAnswer(_ selectedOption: String) {
        if selectedOption == questions[currentQuestionIndex].correctAnswer {
            score += 1
            answerCorrect = true
        } else {
            answerCorrect = false
        }
        showAnswerAlert = true
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            if answerCorrect {
                resetTimer()
            }
        } else {
            showTimeUpModal = true
        }
    }
    
    func startTimer() {
        timerActive = true
        timer = Timer.publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timerActive {
                    if timeRemaining > 0 {
                        withAnimation(.linear(duration: 0.05)) {
                            timeRemaining -= 0.05
                        }
                    } else {
                        timer?.cancel()
                        timerActive = false
                        showTimeUpModal = true
                    }
                }
            }
    }

    func resetTimer() {
        timeRemaining = totalTime
        timerActive = true
    }
    
    func resetGame() {
        timeRemaining = totalTime
        currentQuestionIndex = 0
        score = 0
        showTimeUpModal = false
        showRulesModal = true
        timer?.cancel()
    }

    func returnToHome() {
        // Lógica para regresar a la pantalla de inicio
    }
}

struct TimeUpView: View {
    let score: Int
    let onRetry: () -> Void
    let onReturnToHome: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("¡Se acabó el tiempo!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Tu puntuación: \(score)")
                .font(.title)
            
            Button(action: onRetry) {
                Text("Jugar de nuevo")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Button(action: onReturnToHome) {
                Text("Regresar al inicio")
                    .font(.headline)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .padding()
    }
}

struct GameRulesQuizView: View {
    let timeLimit: Double
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image("line")
                .resizable()
                .scaledToFit()
            
            Text("Reglas del Juego")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(Color.azulMexicano)
                .foregroundColor(.white)
                .padding(.vertical, 20)
            
            VStack {
                
                Text("Adivina la traducción correcta del emoji antes de que el tiempo se acabe.")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                                
                Text("Tienes \(Int(timeLimit)) segundos para completar cada pregunta.")
                .font(.title3)
                .multilineTextAlignment(.center)
                
                Button(action: onDismiss) {
                    Text("¡Entendido!")
                        .font(.headline)
                        .padding()
                        .background(Color.rosaMexicano)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }.padding(.horizontal)
            
            Image("line")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(180))
        }
    }
}

#Preview {
    ImageQuizView()
}
