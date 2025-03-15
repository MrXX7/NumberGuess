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

    // Constants for customization
    private let buttonSpacing: CGFloat = 2
    private let rowSpacing: CGFloat = 4
    private let buttonWidth: CGFloat = 80
    private let buttonHeight: CGFloat = 80
    private let clearButtonWidth: CGFloat = 127

    // Number pad layout
    private let numberPadRows = [
        ["1", "2", "3", "4"],
        ["5", "6", "7", "8"],
        ["9", "0"]
    ]

    var body: some View {
        VStack(spacing: rowSpacing) {
            ForEach(numberPadRows, id: \.self) { row in
                HStack(spacing: buttonSpacing) {
                    ForEach(row, id: \.self) { number in
                        NumberButton(number: number, guess: $guess, feedback: $feedback)
                            .buttonStyle(CustomButtonStyleTwo())
                            .frame(width: buttonWidth, height: buttonHeight)
                    }

                    // Add Clear button to the last row
                    if row == numberPadRows.last {
                        clearButton
                    }
                }
            }
        }
        .padding()
        .background(Color.clear)
        .cornerRadius(10)
    }

    // MARK: - Clear Button
    private var clearButton: some View {
        Button(action: clearInput) {
            Text("Clear")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: clearButtonWidth, height: buttonHeight)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.mint, Color.black]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(10)
        }
    }

    // MARK: - Clear Input Action
    private func clearInput() {
        feedback = Array(repeating: .gray, count: 4)
        guess = ""
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



