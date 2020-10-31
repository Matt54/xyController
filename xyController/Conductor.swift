//
//  Conductor.swift
//  xyController
//
//  Created by Matt Pfeiffer on 10/30/20.
//

import Foundation
import AudioKit

class Conductor: ObservableObject{
    
    ///AudioKits Wrapper for AVAudioEngine
    private var audioEngine: AudioEngine
    
    public static let shared = Conductor()
    
    init(){
        audioEngine = AudioEngine()
        
        do{
            try audioEngine.start()
        }
        catch{
            print(error)
        }
    }
    
}
