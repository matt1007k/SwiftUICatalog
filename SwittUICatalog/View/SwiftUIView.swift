//
//  SwiftUIView.swift
//  SwittUICatalog
//
//  Created by Max Meza on 12/8/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var agreementChecked: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Back Button
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(.systemGray))
                    .frame(width: 24, height: 24)
            }
            .padding(.top, 53)
            .padding(.leading, 25)
            
            // Header
            HStack(spacing: 6) {
                Text("Regístrate con nosotros")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(red: 0.23, green: 0.23, blue: 0.23))
                
                Image("waving_hand")
                    .frame(width: 22, height: 22)
            }
            .padding(.top, 45)
            .padding(.leading, 25)
            
            Text("Ingresa un correo electrónico valido y una contraseña para crear tu cuenta en MuniDigital")
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
                .padding(.top, 20)
                .padding(.horizontal, 25)
            
            // Email Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Correo electrónico")
                    .font(.system(size: 14, weight: .semibold))
                
                HStack {
                    TextField("Email", text: $email)
                        .font(.system(size: 16, weight: .medium))
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                }
                Divider()
                    .frame(height: 1.5)
                    .background(Color.black)
            }
            .padding(.top, 52)
            .padding(.horizontal, 25)
            
            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Crear una contraseña")
                    .font(.system(size: 14, weight: .semibold))
                
                HStack {
                    if isPasswordVisible {
                        TextField("Crea tu contraseña", text: $password)
                    } else {
                        SecureField("Crea tu contraseña", text: $password)
                    }
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.gray)
                    }
                }
                Divider()
                    .frame(height: 1.5)
                    .background(Color.black)
            }
            .padding(.top, 50)
            .padding(.horizontal, 25)
            
            // Agreement
            HStack(alignment: .top, spacing: 10) {
                Button(action: { agreementChecked.toggle() }) {
                    RoundedRectangle(cornerRadius: 3)
                        .strokeBorder(Color.black, lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .overlay(
                            agreementChecked ? Image(systemName: "checkmark")
                                .foregroundColor(.black) : nil
                        )
                }
                
                Text("He leído y acepto los términos y condiciones y Aviso de privacidad")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
            .padding(.top, 50)
            .padding(.horizontal, 25)
            
            // Continue Button
            Button(action: {}) {
                Text("Continuar")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(Color(red: 0.96, green: 0.26, blue: 0.21))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.35), radius: 10, x: 4, y: 4)
            }
            .padding(.top, 50)
            .padding(.horizontal, 25)
            
            // Login Link
            HStack(spacing: 6) {
                Text("Ya tienes una cuenta?")
                    .font(.system(size: 14, weight: .medium))
                Text("Inicia sesión")
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding(.top, 30)
            
            // Social Login
            VStack(spacing: 20) {
                HStack {
                    Divider()
                        .frame(width: 117, height: 1.5)
                        .background(Color(red: 0.94, green: 0.93, blue: 0.93))
                    Text("o continuar con")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(red: 0.62, green: 0.69, blue: 0.69))
                    Divider()
                        .frame(width: 117, height: 1.5)
                        .background(Color(red: 0.94, green: 0.93, blue: 0.93))
                }
                
                HStack(spacing: 22) {
                    socialLoginButton(image: "google")
                    socialLoginButton(image: "facebook")
                    socialLoginButton(image: "apple")
                }
            }
            .padding(.top, 30)
            .padding(.horizontal, 25)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(20)
    }
    
    private func socialLoginButton(image: String) -> some View {
        Button(action: {}) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .frame(width: 110, height: 55)
                .overlay(
                    RoundedRectangle(cornerRadius: 17)
                        .stroke(Color(red: 0.94, green: 0.93, blue: 0.93), lineWidth: 1)
                )
        }
    }
}

#Preview {
    RegisterView()
}
