//
//  CustomTabBottom.swift
//  SwittUICatalog
//
//  Created by Max Meza on 12/12/24.
//

import SwiftUI

struct CustomBottomNavigationBar: View {
    var body: some View {
        HStack {
            // Home Button
            NavigationItem(icon: "house.fill", label: "Home", isSelected: true)

            Spacer()

            // Favorites Button
            NavigationItem(icon: "heart", label: "Favorites", isSelected: false)

            Spacer()

            // Center Button
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 56, height: 56)
                    .shadow(radius: 4)
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }

            Spacer()

            // Share Button
            NavigationItem(icon: "square.and.arrow.up", label: "Share", isSelected: false)

            Spacer()

            // Profile Button
            ProfileIcon(imageName: "avatar-default") // Replace with your asset name
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(Color(UIColor(red: 0.91, green: 0.94, blue: 1.0, alpha: 1.0))) // Light blue background
    }
}

struct NavigationItem: View {
    let icon: String
    let label: String
    let isSelected: Bool

    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(isSelected ? Color.blue : Color.gray)

            Text(label)
                .font(.footnote)
                .foregroundColor(isSelected ? Color.blue : Color.gray)
        }
    }
}

struct ProfileIcon: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.green, lineWidth: 2) // Green border
            )
    }
}

struct CustomTabBottom: View {
    var body: some View {
        VStack {
            Spacer()
            CustomBottomNavigationBar()
        }
    }
}

#Preview {
    CustomTabBottom()
}
