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

func feedbackCircles(feedback: [Color], guessedNumbers: [Int]) -> some View {
    HStack {
        ForEach(feedback.indices, id: \.self) { index in
            let color = feedback[index]
            let number = guessedNumbers.indices.contains(index) ? guessedNumbers[index] : nil // Eğer girilen numaraların indeksi mevcut ise, numarayı al. Yoksa nil yap.
            
            RoundedRectangle(cornerRadius: 10)
                .fill(color != .gray ? color : color.opacity(0.5)) // Gri olan renklerin arka planı saydam olacak
                .overlay(
                    Text(number != nil ? String(number!) : "") // Eğer numara mevcutsa, hücreye numarayı yaz. Değilse boş bırak.
                        .foregroundColor(.white)
                        .font(.largeTitle)
                )
                .frame(width: 50, height: 50)
                .padding(5)
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

