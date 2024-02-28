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
    
    var body: some View {
        VStack {
            Text("Enter the 4-digit number you guessed:")
                .font(.headline)
            TextField("Guess", text: $guess)
                .padding()
                .font(.title)
                .keyboardType(.numberPad)
            Button("Guess") {
                checkGuess()
            }
            Button("Reset") {
                resetGame()
            }
            HStack {
                ForEach(feedback, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 40, height: 40)
                }
            }
        }
        .padding()
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
    
    func resetGame() {
        guess = ""
        feedback = [Color.gray, Color.gray, Color.gray, Color.gray]
        target = String(format: "%04d", Int.random(in: 0..<10000))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



