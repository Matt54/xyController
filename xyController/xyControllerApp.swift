//
//  xyControllerApp.swift
//  xyController
//
//  Created by Matt Pfeiffer on 10/30/20.
//

import SwiftUI

@main
struct xyControllerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Conductor.shared)
        }
    }
}
