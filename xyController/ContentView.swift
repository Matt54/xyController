//
//  ContentView.swift
//  xyController
//
//  Created by Matt Pfeiffer on 10/30/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var conductor: Conductor
    
    var body: some View {
        GeometryReader { geometry in
            PadControllerView(padController: $conductor.padController)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Conductor.shared)
            .previewLayout(.fixed(width: 812, height: 375)) //Landscape
    }
}
