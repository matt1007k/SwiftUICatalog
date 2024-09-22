//
//  MapBottonSheet.swift
//  SwittUICatalog
//
//  Created by Max Meza on 9/8/24.
//

import SwiftUI
import MapKit

struct MapBottonSheetScreen: View {
    
    @State private var showSheet: Bool = false
    @State private var activeTab: TabMapBottomSheet = .devices
    @State private var ignoreTabBar: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            /// This Project Supports iOS 16
            if #available(iOS 17, *) {
                Map(initialPosition: .region(.applePark))
            } else {
                Map(coordinateRegion: .constant(.applePark))
            }
            
            TabBar()
                .frame(height: 49)
                .background(.regularMaterial)
        }
        .task {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            ScrollView(.vertical){
                VStack(alignment: .leading, spacing: 10, content: {
                    Text(activeTab.rawValue)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Toggle("Ignore Tab Bar", isOn: $ignoreTabBar)
                })
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .presentationDetents([.height(60), .medium, .large])
            .presentationCornerRadius(20)
            .presentationBackground(.regularMaterial)
            .presentationBackgroundInteraction(.enabled(upThrough: .large))
            .interactiveDismissDisabled() // Disabled hidden bottom
            // Add it inside Sheet View
            .bottomMaskForSheet(mask: !ignoreTabBar)
        }
    }
    
    @ViewBuilder
    func TabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(TabMapBottomSheet.allCases, id: \.rawValue) { tab in
                Button(action: { activeTab = tab }, label: {
                    VStack(spacing: 2) {
                        Image(systemName: tab.symbol)
                            .font(.title2)
                        
                        Text(tab.rawValue)
                            .font(.caption2)
                    }
                    .foregroundStyle(activeTab == tab ? Color.accentColor : .gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(.rect)
                })
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    MapBottonSheetScreen()
}

extension MKCoordinateRegion {
    /// Apple Mark Region
    static var applePark: MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: 37.334606, longitude: -122.009102)
        return .init(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
