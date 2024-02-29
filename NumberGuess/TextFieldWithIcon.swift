//
//  TextFieldWithIcon.swift
//  NumberGuess
//
//  Created by Oncu Can on 29.02.2024.
//

import SwiftUI

struct TextFieldWithIcon: View {
    @Binding var guess: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(height: 50)
                .padding()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            
            HStack {
                Image(systemName: "number")
                    .foregroundColor(.blue)
                    .padding(.leading, 20)
                TextField("Enter your guess", text: $guess)
                    .padding(.horizontal)
                    .font(.title)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 50)
    }
}
