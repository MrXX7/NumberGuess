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
                
                HStack {
                    TextField("Enter code", text: $guess)
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                        .keyboardType(.numberPad)
                        .onChange(of: guess) { newValue in
                            
                            feedback = Array(repeating: .gray, count: 4)
                            
                            
                            if newValue.count >= 5 {
                                guess = String(newValue.dropLast())
                            }
                        }
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    
                    Button(action: {
                        guess = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.horizontal, 15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            )
        }
    }
}















