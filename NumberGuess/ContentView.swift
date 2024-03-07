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
    
//    String(format: "%04d", Int.random(in: 0..<10000))
    @State private var remainingAttempts = 6
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Crack the Code:")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                feedbackCircles(feedback: feedback, guessedNumbers: Array(guess).compactMap { Int(String($0)) })
                
                TextFieldWithIcon(guess: $guess, feedback: $feedback).frame(width: UIScreen.main.bounds.width * 0.65)
                
                    .padding(.top, 10)
                
                HStack(spacing: 100) {
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
                
                Text("Chances Left: \(remainingAttempts)")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Spacer()
                
                if feedback.allSatisfy({ $0 == Color.green }) {
                    Text("Congratulations! 🎉")
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








