//
//  Pad.swift
//  xyController
//
//  Created by Matt Pfeiffer on 10/30/20.
//

import SwiftUI

struct Pad: View {
   
    @Binding var model: PadModel
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(model.isOn ? Color.green : Color.gray)
                .border(Color.black, width: geometry.size.width * 0.02)
        }
    }
    
}

struct Pad_Previews: PreviewProvider {
    static var previews: some View {
        Pad( model: .constant(PadModel()) ).frame(width: 200, height: 200)
    }
}
