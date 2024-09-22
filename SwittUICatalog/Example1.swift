//
//  Example1.swift
//  SwittUICatalog
//
//  Created by Max Meza on 7/21/24.
//

import SwiftUI

struct Example1: View {
    var gridColumn = Array(repeating: GridItem(.adaptive(minimum: 120, maximum: 220), spacing: 20), count: 3)
    
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                    ForEach(0..<10) { position in
                        Text("Number \(position)")
                            .alignmentGuide(.leading) { _ in Double(position) * -10 }
                    }
                }
                .background(.red)
                .frame(width: 400, height: 400)
                .background(.blue)
            
            ScrollView{
                LazyVGrid(columns: gridColumn, content: {
                    ForEach(0..<10) { i in
                        VStack{
                            Text("text \(i)")
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .overlay {
                            RoundedRectangle(cornerRadius: 16.0)
                        }
                    }
                    
                })
                .padding()
            }
                
        }
        
        
        
    }
    
     func Solution1() -> some View {
        return GeometryReader { content in
            let size = content.size
            VStack{
                HStack {
                    ZStack(alignment: Alignment.center, content: {
                        Text("Ejemplo 1")
                    })
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: size.height * 0.3)
                .background(Color.cyan)
                
               
                HStack {
                    ZStack(alignment: Alignment.center, content: {
                        Text("Ejemplo 2")
                    })
                    .frame(width: size.width * 0.5)
                    .frame( maxHeight: .infinity)
                    .background(Color.red)
                    
                    ZStack(alignment: Alignment.center,
                           content: {
                        Text(
                            "Ejemplo 3"
                        )
                    })
                    .frame(
                        width: size.width * 0.5,
                        alignment: .center
                    )
                    .frame(
                        maxHeight: .infinity
                    )
                    .background(
                        Color.green
                    )
                    
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: size.height * 0.3)
                
                HStack {
                    ZStack(content: {
                        Text("Ejemplo 4")
                        
                    })
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: size.height * 0.3, alignment: .bottomLeading)
                .background(Color.indigo)
               
            }
            .frame(maxHeight: .infinity)
            
        }
    }
    
}

#Preview {
    Example1()
}
