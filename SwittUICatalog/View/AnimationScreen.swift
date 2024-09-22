//
//  AnimationScreen.swift
//  SwittUICatalog
//
//  Created by Max Meza on 8/27/24.
//

import SwiftUI

struct AnimationScreen: View {
    var body: some View {
        VStack {
            RatingView()
        }
        .navigationTitle("Animations")
    }
}

#Preview {
    AnimationScreen()
}

struct RatingView: View {
    @State private var rating: Int = 5
    var body: some View {
        HStack {
            Button("", systemImage: "minus.circle") {
                withAnimation {
                    rating -= 1
                }
            }
            .font(.largeTitle)
            .disabled(rating == 0)
            
            Text(String(format: "%02d", rating))
                .font(.system(size: 50))
                .fontWeight(.bold)
                .contentTransition(.numericText(value: Double(rating)))
            
            Button("", systemImage: "plus.circle") {
                withAnimation {
                    rating += 1
                }
            }
            .font(.largeTitle)
            .disabled(rating == 15)
            
        }
    }
}
