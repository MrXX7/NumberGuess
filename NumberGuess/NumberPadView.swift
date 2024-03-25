//
//  NumberPadView.swift
//  NumberGuess
//
//  Created by Oncu Can on 13.03.2024.
//

import SwiftUI

struct NumberPadView: View {
    @Binding var guess: String
    @Binding var feedback: [Color]

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 2) {
                NumberButton(number: "1", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
                NumberButton(number: "2", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
                NumberButton(number: "3", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
                NumberButton(number: "4", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
            }
            HStack(spacing: 2) {
                NumberButton(number: "5", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
                NumberButton(number: "6", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
                NumberButton(number: "7", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
                NumberButton(number: "8", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
            }
            HStack(spacing: 2) {
                NumberButton(number: "9", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
                NumberButton(number: "0", guess: $guess, feedback: $feedback)
                    .buttonStyle(CustomButtonStyleTwo())
                Button(action: {
                    feedback = Array(repeating: .gray, count: 4)
                    guess = ""
                }) {
                    Text("Clear")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(width: 127)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.mint, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.clear)
        .cornerRadius(10)
    }
}


struct NumberButton: View {
    let number: String
    @Binding var guess: String
    @Binding var feedback: [Color]
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            if self.number == "Clear" {
                self.guess = ""
            } else {
                self.guess += self.number
            }
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }) {
            Text(number)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .scaleEffect(isPressed ? 0.8 : 1.0)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    self.isPressed = true
                })
                .onEnded({ _ in
                    self.isPressed = false
                })
        )
    }
}



