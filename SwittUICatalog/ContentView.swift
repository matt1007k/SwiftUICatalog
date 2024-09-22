//
//  ContentView.swift
//  SwittUICatalog
//
//  Created by Max Meza on 7/21/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
   
    @Environment(\.navigate) private var navigate
   
    var body: some View {
        List {
            ForEach(Route.allCases, id: \.hashValue) { route in
                Button(action: {
                    navigate(route)
                }, label: {
                    Text("navigation \(route)")
                })
            }
        }
        
        
        Text("horizontalSizeClass::: \(horizontalSizeClass)")
            .padding()
        Text("verticalSizeClass::: \(verticalSizeClass)")
            .padding()
       
    }
}

#Preview {
    ContentView()
}


