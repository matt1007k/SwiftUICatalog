//
//  ScrollElementScreen.swift
//  SwittUICatalog
//
//  Created by Max Meza on 8/27/24.
//

import SwiftUI

struct ScrollElementScreen: View {
    var body: some View {
        RegisterView2()
    }
}

#Preview {
    ScrollElementScreen()
}

import SwiftUI

struct RegisterView2: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Back button
                HStack {
                    Button(action: {
                        // Back action
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                
                // Title
                VStack(alignment: .leading, spacing: 5) {
                    Text("Regístrate con nosotros 👋")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("Ingresa un correo electrónico válido y una contraseña para crear tu cuenta en MuniDigital")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Form fields
                VStack(spacing: 15) {
                    // Email field
                    TextField("Correo electrónico", text: .constant(""))
                        .padding()
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        )
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    
                    // Password field
                    SecureField("Crear una contraseña", text: .constant(""))
                        .padding()
                        .overlay(
                            HStack {
                                Spacer()
                                Image(systemName: "eye")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        )
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    
                    // Terms and conditions
                    HStack {
                        Button(action: {
                            // Checkbox toggle
                        }) {
                            Image(systemName: "square")
                                .foregroundColor(.gray)
                        }
                        
                        Text("He leído y acepto los términos y condiciones y Aviso de privacidad")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
                
                // Continue button
                Button(action: {
                    // Continue action
                }) {
                    Text("Continuar")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                        .shadow(color: Color.red.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .padding(.horizontal)
                
                // Login link
                Text("Ya tienes una cuenta? Inicia sesión")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                // Divider with social options
                HStack {
                    Divider()
                    Text("o continuar con")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Divider()
                }
                .padding(.horizontal)
                
                // Social media buttons
                HStack(spacing: 20) {
                    SocialButton(iconName: "google", color: .red)
                    SocialButton(iconName: "facebook", color: .blue)
                    SocialButton(iconName: "apple", color: .black)
                }
                .padding(.top)
                
                Spacer()
            }
            .padding(.top)
            .navigationBarHidden(true)
        }
    }
}

struct SocialButton: View {
    var iconName: String
    var color: Color
    
    var body: some View {
        Button(action: {
            // Social login action
        }) {
            Image(systemName: iconName) // Placeholder for icon
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(25)
        }
    }
}

// Preview
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView2()
    }
}
