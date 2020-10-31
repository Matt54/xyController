//
//  Pad.swift
//  xyController
//
//  Created by Matt Pfeiffer on 10/30/20.
//

import SwiftUI

struct Pad: View {
    
    @State var isOn : Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(isOn ? Color.green : Color.gray)
                .border(Color.black, width: geometry.size.width * 0.02)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
                            
                            // Are we inside the view?
                            if(value.location.x < 0.0
                                || value.location.y < 0.0
                                || value.location.x > geometry.size.width
                                || value.location.y > geometry.size.height){
                                isOn = false
                            }
                            
                            else{
                                isOn = true
                            }
                            
                        }
                        .onEnded { _ in
                            isOn = false
                        }
                    
                )
        }
    }
}

struct Pad_Previews: PreviewProvider {
    static var previews: some View {
        Pad().frame(width: 200, height: 200)
    }
}
