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
                Spacer()
                Text("Guess the 4-digit number:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                feedbackCircles(feedback: feedback, animate: animate)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(height: 50)
                        .padding()
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                    
                    HStack {
                        Image(systemName: "number")
                            .foregroundColor(.blue) // Metin rengini mavi yap
                            .padding(.leading, 20) // İkonu sola yasla
                        TextField("Enter your guess", text: $guess)
                            .padding(.horizontal)
                            .font(.title) // Metni daha büyük yap
                            .foregroundColor(.black) // Metin rengini siyah yap
                    }
                }
                .padding(.horizontal, 50)

                
                
                HStack(spacing: 20) {
                    Button("Guess") {
                        withAnimation {
                            checkGuess(guess: guess, target: target, feedback: &feedback)
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
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                if feedback.allSatisfy({ $0 == Color.green }) {
                    Text("Congratulations! You guessed it right.")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                } else if remainingAttempts == 0 {
                    Text("You've used all your attempts. The correct answer was \(target).")
                        .font(.title)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}








