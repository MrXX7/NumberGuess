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
    @State private var target = generateUniqueCode()
    @State private var remainingAttempts = 6
    @State private var showCongratulations = false
    @State private var isPressed = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.mint, Color.black.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                StatusView(feedback: $feedback, showCongratulations: $showCongratulations, remainingAttempts: $remainingAttempts, target: target)
                
                let guessedNumbersArray = guess.compactMap { Int(String($0)) }
                let guessedNumbersBinding = Binding.constant(guessedNumbersArray)
                
                FeedbackCirclesView(feedback: $feedback, guessedNumbers: guessedNumbersBinding, guess: $guess)
                
                NumberPadView(guess: $guess, feedback: $feedback)
                
                HStack(spacing: 88) {
                    Button("Try Now"){
                        if remainingAttempts > 0 {
                            withAnimation {
                                checkGuess(guess: guess, target: target, feedback: &feedback)
                                remainingAttempts -= 1
                            }
                        }
                    }
                    
                    .buttonStyle(CustomButtonStyleThird())
                    
                    Button(remainingAttempts == 0 || feedback.allSatisfy({ $0 == Color.green }) ? "Again" : "Reset") {
                        withAnimation {
                            resetGame(guess: &guess, feedback: &feedback, target: &target, remainingAttempts: &remainingAttempts)
                        }
                    }
                    .buttonStyle(CustomButtonStyleThird())
                }
                .padding(.top, 1)
                
                Text("Chances Left: \(remainingAttempts)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Spacer()
                
                Text("© 2024 by Oncu Can. All rights reserved.")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}








