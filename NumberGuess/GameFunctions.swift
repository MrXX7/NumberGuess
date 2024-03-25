//
//  GameFunctions.swift
//  NumberGuess
//
//  Created by Oncu Can on 29.02.2024.
//

import SwiftUI

func resetGame(guess: inout String, feedback: inout [Color], target: inout String, remainingAttempts: inout Int) {
    guess = ""
    feedback = [Color.gray, Color.gray, Color.gray, Color.gray]
    target = String(format: "%04d", Int.random(in: 0..<10000))
    remainingAttempts = 6
}

func checkGuess(guess: String, target: String, feedback: inout [Color]) {
    var reds = 0
    var yellows = 0
    var yellowIndices: [Int] = []
    var correctIndices: [Int] = [] 
    let guessArray = Array(guess)
    let targetArray = Array(target)
    
    for i in 0..<4 {
        if guessArray[i] == targetArray[i] {
            reds += 1
            feedback[i] = Color.green
            correctIndices.append(i)
        }
    }
    
    for i in 0..<4 {
        if guessArray[i] != targetArray[i] && targetArray.contains(guessArray[i]) {
            
            let correctIndex = targetArray.firstIndex(of: guessArray[i])!
            if !correctIndices.contains(correctIndex) && !yellowIndices.contains(i) {
                yellows += 1
                feedback[i] = Color.yellow
                yellowIndices.append(i)
            }
        }
    }
    
    for i in 0..<4 {
        if !correctIndices.contains(i) && !targetArray.contains(guessArray[i]) {
            feedback[i] = Color.red
        }
    }
    
    if guessArray.count < 4 {
        feedback = Array(repeating: .gray, count: 4)
    }
}



func feedbackCircles(feedback: [Color], guessedNumbers: [Int]) -> some View {
    HStack {
        ForEach(feedback.indices, id: \.self) { index in
            let color = feedback[index]
            let number = guessedNumbers.indices.contains(index) ? guessedNumbers[index] : nil
            
            RoundedRectangle(cornerRadius: 10)
                .fill(color != .gray ? color : color.opacity(0.5))
                .overlay(
                    Text(number != nil ? String(number!) : "")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                )
                .frame(width: 50, height: 50)
                .padding(5)
        }
    }
}

func generateUniqueCode() -> String {
    var code = ""
    var counts: [Character: Int] = [:]

    let firstDigit = Int.random(in: 1..<10)
    code.append(Character("\(firstDigit)"))
    counts[Character("\(firstDigit)"), default: 0] += 1

    while code.count < 4 {
        let randomNumber = Int.random(in: 0..<10)
        let randomCharacter = Character("\(randomNumber)")

        if counts[randomCharacter, default: 0] < 2 {
            code.append(randomCharacter)
            counts[randomCharacter, default: 0] += 1
        }
    }

    return code
}



struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.8), Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
            .shadow(color: .gray, radius: configuration.isPressed ? 3 : 5, x: 0, y: configuration.isPressed ? 2 : 3)
    }
}

struct CustomButtonStyleTwo: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.teal, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
            .shadow(color: .gray, radius: configuration.isPressed ? 3 : 5, x: 0, y: configuration.isPressed ? 2 : 3)
    }
}

struct CustomButtonStyleThird: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.mint, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(10)
            .shadow(color: .gray, radius: configuration.isPressed ? 3 : 5, x: 0, y: configuration.isPressed ? 2 : 3)
    }
}

