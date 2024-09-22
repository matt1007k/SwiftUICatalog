//
//  SwittUICatalogApp.swift
//  SwittUICatalog
//
//  Created by Max Meza on 7/21/24.
//

import SwiftUI

@main
struct SwittUICatalogApp: App {
    @State private var routes: [Route] = []
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $routes) {
                ContentView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .avatar:
                                ProfileScreen()
                            case .button:
                                ButtonScreen()
                            case .scroll:
                                ScrollElementScreen()
                            case .animation:
                                AnimationScreen()
                            case .formValidation:
                                FormValidationScreen()
                        }
                    }
            }.environment(\.navigate) { route in
                routes.append(route)
            }
            
        }
    }
}



enum Route: Hashable, CaseIterable {
    case avatar,
         button,
         scroll,
         animation,
         formValidation
}


struct NavigateEnvironmentKey: EnvironmentKey {
    static var defaultValue: (Route) -> Void = { _ in }
}

extension EnvironmentValues {
    var navigate: (Route) -> Void {
        get { self[NavigateEnvironmentKey.self] }
        set { self[NavigateEnvironmentKey.self] = newValue }
    }
}
