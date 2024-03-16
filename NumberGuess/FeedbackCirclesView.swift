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
                        // Kullanıcının belirlediği rakamı değiştir
                        // Burada kullanıcının seçtiği yeni rakamı belirlemelisiniz
                        let newNumber = 0 // Örneğin, kullanıcı tarafından belirlenen yeni rakam
                        guessedNumbers[index] = newNumber
                        // guessedNumbers dizisini değiştirdiğimizde, feedback dizisini de güncelleyelim
                        self.updateFeedback()
                    }
            }
        }
    }

    func updateFeedback() {
        // feedback dizisini, guessedNumbers dizisine göre güncelleyelim
        // Örneğin, her rakam için farklı bir renk kullanılabilir
        self.feedback = self.guessedNumbers.map { number in
            // Örneğin, her rakam için farklı bir renk belirleyebiliriz
            return Color(red: Double(number) / 10.0, green: 0.5, blue: 0.5)
        }
    }
}

