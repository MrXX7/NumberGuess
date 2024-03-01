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
        ZStack {
            HStack {
                Image(systemName: "number")
                    .foregroundColor(.gray)
                    .font(.title)
                    .padding(.leading, 1)
                
                TextField("Enter your guess", text: $guess)
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .keyboardType(.numberPad)
                    .onChange(of: guess) { _ in
                        feedback = Array(repeating: .gray, count: 4)
                    }
            }
        .padding(.horizontal, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            )}
    }
}














