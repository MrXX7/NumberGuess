//
//  ContentView.swift
//  NumberGuess
//
//  Created by Oncu Can on 28.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var guess = ""
    @State private var feedback = [Color.gray, Color.gray, Color.gray, Color.gray]
    @State private var target = String(format: "%04d", Int.random(in: 0..<10000))
    @State private var animate = false
    @State private var remainingAttempts = 6 // Kullanıcının kalan deneme hakkı
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom) // Arka planı görsel bir geçişle değiştir
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Guess the 4-digit number:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                HStack {
                    ForEach(feedback, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(width: 50, height: 50)
                            .padding(5)
                            .scaleEffect(animate ? 1.1 : 1.2)
                            .animation(.easeInOut(duration: 0.5))
                    }
                }
                
                TextField("Enter your guess", text: $guess)
                    .padding()
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2) // Gölgelendirme ekleyerek yükseltme
                    )
                    .padding(.horizontal, 50)

                
                HStack(spacing: 20) {
                    Button("Guess") {
                        withAnimation {
                            checkGuess()
                            remainingAttempts -= 1
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Button("Reset") {
                        withAnimation {
                            resetGame(guess: &guess, feedback: &feedback, target: &target, remainingAttempts: &remainingAttempts)
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                }
                .padding(.top, 20)
                
                Text("Remaining Attempts: \(remainingAttempts)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                if feedback.allSatisfy({ $0 == Color.green }) {
                    Text("Congratulations! You guessed it right.")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                } else if remainingAttempts == 0 {
                    Text("You've used all your attempts. The correct answer was \(target).")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                }
                
                Spacer()
            }
        }
        .onAppear {
            animate = true
        }
    }
    
    func checkGuess() {
        var reds = 0
        var yellows = 0
        let guessArray = Array(guess)
        let targetArray = Array(target)
        
        for i in 0..<4 {
            if guessArray[i] == targetArray[i] {
                reds += 1
                feedback[i] = Color.green
            } else if targetArray.contains(guessArray[i]) {
                yellows += 1
                feedback[i] = Color.yellow
            } else {
                feedback[i] = Color.red
            }
        }
    }
    }

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}








