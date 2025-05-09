//
//  DrawAreaMapView.swift
//  SwittUICatalog
//
//  Created by Max Meza on 12/12/24.
//

import SwiftUI
import MapKit

struct MapViewWithOverlay: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var overlays: [MKOverlay] // Pass the overlays (polygons, circles, etc.)
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: false)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.removeOverlays(uiView.overlays) // Clear existing overlays
        uiView.addOverlays(overlays) // Add new overlays
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polygon = overlay as? MKPolygon {
                let renderer = MKPolygonRenderer(polygon: polygon)
                renderer.fillColor = UIColor.systemBlue.withAlphaComponent(0.3) // Fill color
                renderer.strokeColor = UIColor.systemBlue // Border color
                renderer.lineWidth = 2
                return renderer
            } else if let circle = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circle)
                renderer.fillColor = UIColor.systemGreen.withAlphaComponent(0.3)
                renderer.strokeColor = UIColor.systemGreen
                renderer.lineWidth = 2
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}

struct MapWithPolygonView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        let polygon = MKPolygon(coordinates: [
            CLLocationCoordinate2D(latitude: 37.784, longitude: -122.409),
            CLLocationCoordinate2D(latitude: 37.774, longitude: -122.419),
            CLLocationCoordinate2D(latitude: 37.764, longitude: -122.429),
        ], count: 3) // A triangle

        MapViewWithOverlay(region: $region, overlays: [polygon])
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapWithCircleView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), // New York
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), radius: 1000)

        MapViewWithOverlay(region: $region, overlays: [circle])
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapWithPolylineView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), // Los Angeles
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        let coordinates = [
            CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), // Point A
            CLLocationCoordinate2D(latitude: 34.0622, longitude: -118.2537), // Point B
            CLLocationCoordinate2D(latitude: 34.0722, longitude: -118.2637)  // Point C
        ]
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)

        MapViewWithOverlay(region: $region, overlays: [polyline])
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview { MapWithPolygonView() }

#Preview { MapWithPolylineView() }
