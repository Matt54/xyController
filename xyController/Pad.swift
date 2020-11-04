//
//  Pad.swift
//  xyController
//
//  Created by Matt Pfeiffer on 10/30/20.
//

import SwiftUI

struct Pad: View {
   
    @Binding var model: PadModel
    @Binding var ccVal : Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom){
        
                // Back Rectangle
                Rectangle()
                    .fill(model.isOn ?
                            LinearGradient(gradient: Gradient(colors: [.red, .yellow, .green]), startPoint: .top, endPoint: .center)
                            : LinearGradient(gradient: Gradient(colors: [.gray]), startPoint: .top, endPoint: .center))
                
                // Front Blocking Rectangle
                Rectangle()
                    .fill(Color.gray)
                    .mask(Rectangle().padding(.bottom, geometry.size.height * CGFloat(Double(ccVal) / 127.0) ))
                    
                
            }
            .border(Color.black, width: geometry.size.width * 0.02)
        }
    }
    
}

struct Pad_Previews: PreviewProvider {
    static var previews: some View {
        Pad( model: .constant(PadModel()), ccVal: .constant(50) ).frame(width: 200, height: 200)
    }
}
