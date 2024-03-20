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
    
    var body: some View {
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
                    .onTapGesture {
                        let tappedIndex = index
                        guessedNumbers[tappedIndex] = 0
                        guess = ""
                    }
            }
        }
    }
    
    func updateFeedback() {
        // feedback dizisini, guessedNumbers dizisine göre güncelleyelim
        self.feedback = self.guessedNumbers.map { number in
            // Eğer rakam 0 ise şeffaf bir renk kullanalım, aksi halde renk belirleyelim
            return Color.clear
        }
    }
}

