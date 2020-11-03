//
//  PadControllerView.swift
//  xyController
//
//  Created by Matt Pfeiffer on 11/1/20.
//

import SwiftUI

struct PadControllerView: View {
    
    @Binding var padController : PadController
    
    var body: some View {
        GeometryReader { geometry in
            // add all the pads
            HStack(spacing: 0){
                ForEach(padController.pads.indices, id: \.self){ i in
                    Pad(model: $padController.pads[i])
                        .frame(width: geometry.size.width/CGFloat(padController.pads.count))
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in
                        
                        // Are we outside the view?
                        if(value.location.x < 0.0
                            || value.location.y < 0.0
                            || value.location.x > geometry.size.width
                            || value.location.y > geometry.size.height){
                            //isBeingTouched = false
                            padController.indexSelected = -1
                        }
                        
                        // Determine which pad was touched and let the padController know the index
                        else{
                            let xRatioOfWidth = Double(value.location.x / geometry.size.width)
                            let yRatioOfHeight = 1.0 - Double(value.location.y / geometry.size.height)
                            padController.handleGestureValues(newX: xRatioOfWidth, newY: yRatioOfHeight)
                        }
                        
                    }
                    .onEnded { _ in
                        padController.indexSelected = -1
                    }
            )
        }
    }
    
}

struct PadControllerView_Previews: PreviewProvider {
    static var previews: some View {
        PadControllerView( padController: .constant(PadController()) )
            .previewLayout(.fixed(width: 812, height: 375)) //Landscape
    }
}
