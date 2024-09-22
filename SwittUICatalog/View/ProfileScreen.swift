//
//  ProfileScreen.swift
//  SwittUICatalog
//
//  Created by Max Meza on 8/11/24.
//

import SwiftUI

struct ProfileScreen: View {
    @State private var viewModel = ProfileViewModel()
    var body: some View {
        let user = viewModel.user
        VStack(spacing: 20) {
            if user != nil {
                AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 120, height: 120)
                        .scaledToFit()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .overlay {
                            Circle()
                                .stroke(LinearGradient(colors: [.accentColor, .primary], startPoint: .top, endPoint: .bottom), lineWidth: 5)
                        }
                } placeholder: {
                    Circle()
                        .foregroundStyle(.secondary)
                        .frame(width: 120, height: 120)
                }
                
                Text(user?.login ?? "")
                    .bold()
                    .font(.title3)
                Text(user?.bio ?? "")
                    .padding()
                
                Spacer()
                
            } else {
                ProgressView()
            }
            
        }
        .padding()
        .task {
            await viewModel.getUser()
        }
    }
}

#Preview {
    ProfileScreen()
}
