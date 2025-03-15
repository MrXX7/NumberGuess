//
//  FeedbackCirclesView.swift
//  NumberGuess
//
//  Created by Oncu Can on 17.03.2024.
//

import SwiftUI

struct FeedbackCirclesView: View {
    @Binding var feedback: [Color]
    @Binding var guessedNumbers: [Int]
    @Binding var guess: String
    
    // Constants for customization
    private let circleSize: CGFloat = 50
    private let cornerRadius: CGFloat = 10
    private let padding: CGFloat = 5
    private let fontSize: Font = .largeTitle
    
    var body: some View {
        HStack(spacing: padding) {
            ForEach(feedback.indices, id: \.self) { index in
                feedbackCircle(for: index)
            }
        }
    }
    
    // MARK: - Feedback Circle
    private func feedbackCircle(for index: Int) -> some View {
        let color = feedback[index]
        let number = guessedNumbers.indices.contains(index) ? guessedNumbers[index] : nil
        
        return RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color != .gray ? color : color.opacity(0.5))
            .overlay(
                Text(number != nil ? String(number!) : "")
                    .foregroundColor(.white)
                    .font(fontSize)
            )
            .frame(width: circleSize, height: circleSize)
            .onTapGesture {
                handleTap(at: index)
            }
    }
    
    // MARK: - Handle Tap Gesture
    private func handleTap(at index: Int) {
        guessedNumbers[index] = 0 // Reset the guessed number
        guess = "" // Clear the guess input
    }
    
    // MARK: - Update Feedback
    func updateFeedback() {
        feedback = guessedNumbers.map { _ in
            Color.clear // Reset feedback colors
        }
    }
}

