//
//  ButtonScreen.swift
//  SwittUICatalog
//
//  Created by Max Meza on 8/27/24.
//

import SwiftUI

struct ButtonScreen: View {
    @State private var isAnimating = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(AngularGradient(colors: [.green, .pink, .yellow], center: .center, angle: .degrees(isAnimating ? 360 : 0)))
                        .frame(width: 260, height: 60)
                        .blur(radius: 20)
                        .onAppear {
                            withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                                isAnimating = true
                            }
                        }
                    
                    Button {
                        
                    } label: {
                        Text("GRADIENT ANIMATION")
                            .font(.title3.bold())
                            .fontDesign(.monospaced)
                            .foregroundStyle(.black)
                            .frame(width: 260, height: 60)
//                            .background(.teal.opacity(0.4), in: .rect(cornerRadius: 20, style: .continuous))
                            .background(.ultraThinMaterial, in: .rect(cornerRadius: 20, style: .continuous))
                            .overlay {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(.gray.opacity(0.5), lineWidth: 1)
                            }
                        
                            
                    }
                }
            }
            .navigationTitle("Buttons")
        }
        
        
    }
}

#Preview {
    ButtonScreen()
}
