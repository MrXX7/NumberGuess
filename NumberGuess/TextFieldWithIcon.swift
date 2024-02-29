//
//  TextFieldWithIcon.swift
//  NumberGuess
//
//  Created by Oncu Can on 29.02.2024.
//

import SwiftUI

struct TextFieldWithIcon: View {
    @Binding var guess: String
    @State private var previousGuess = "" // Önceki tahminin saklandığı state
    @State private var animateFeedback = false // Renklerin animasyonlu olarak değişip değişmeyeceğini kontrol eden flag
    @FocusState private var isFocused: Bool // TextField'in odak durumunu takip eden state

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
                    .focused($isFocused) // TextField'in odak durumunu bağla
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        if guess.isEmpty || guess.count < previousGuess.count { // Yeni değer boşsa veya öncekinden daha kısa ise (silme işlemi yapıldıysa)
                            animateFeedback = false // Animasyonu kapat
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Gecikmeli olarak feedback'i sıfırla
                                resetFeedback()
                            }
                        }
                        if guess.count > 4 { // Girdi 4 rakamdan fazla ise
                            guess = String(guess.prefix(4)) // Sadece ilk 4 rakamı al
                        }
                        previousGuess = guess // Önceki tahmini güncelle
                    }
            }
        }
        .padding(.horizontal, 50)
        .onAppear {
            animateFeedback = true // Animasyonu başlat
        }
    }
    
    // Geri bildirim hücrelerini sıfırlayan fonksiyon
    private func resetFeedback() {
        animateFeedback.toggle() // Animasyonu tersine çevirerek sıfırla
    }
}






