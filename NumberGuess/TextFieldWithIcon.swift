//
//  TextFieldWithIcon.swift
//  NumberGuess
//
//  Created by Oncu Can on 29.02.2024.
//

import SwiftUI

struct TextFieldWithIcon: View {
    @Binding var guess: String
    @Binding var feedback: [Color]

    var body: some View {
        TextField("Enter your guess", text: $guess)
            .padding(.horizontal)
            .font(.title)
            .foregroundColor(.black)
            .padding(.top, 20)
            .onChange(of: guess) { _ in
                // Tahmin yapılmadan önce geri bildirimi sıfırla
                feedback = Array(repeating: .gray, count: 4)
            }
    }
}











