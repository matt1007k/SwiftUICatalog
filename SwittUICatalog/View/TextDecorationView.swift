//
//  TextDecorationView.swift
//  SwittUICatalog
//
//  Created by Max Meza on 4/10/25.
//

import SwiftUI

struct TextDecorationView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.system(size: 80))
            .fontWeight(.black)
            .foregroundStyle(
                LinearGradient(colors: [.pink, .purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
    }
}

#Preview {
    TextDecorationView()
}
