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
            HStack{
                Spacer()
                Pad()
                    .frame(width: 100, height: 100)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Conductor.shared)
    }
}
