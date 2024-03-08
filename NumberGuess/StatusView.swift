//
//  StatusView.swift
//  NumberGuess
//
//  Created by Oncu Can on 8.03.2024.
//

import SwiftUI

struct StatusView: View {
    @Binding var feedback: [Color]
    @Binding var showCongratulations: Bool
    @Binding var remainingAttempts: Int
    var target: String
    
    var body: some View {
        if feedback.allSatisfy({ $0 == Color.green }) {
            Text("Code cracked! 🎉")
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 20)
                .opacity(showCongratulations ? 1 : 0)
                .scaleEffect(showCongratulations ? 1 : 0.1)
                .animation(.easeInOut(duration: 1))
                .onAppear {
                    withAnimation {
                        showCongratulations.toggle()
                    }
                }
        } else if remainingAttempts == 0 {
            Text("You've used all your attempts. The correct answer was \(target).")
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 20)
        } else {
            Text("Crack the Code:")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 50)
        }
    }
}
