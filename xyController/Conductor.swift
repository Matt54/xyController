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
    
    let midi = AudioKit.MIDI()
    
    public var pad = PadModel()
    
    @Published public var padController = PadController()
    
    init(){
        audioEngine = AudioEngine()
        
        midi.openOutput()
        
        do{
            try audioEngine.start()
        }
        catch{
            print(error)
        }
    }
    
    func sendMidiNoteOn(_ midiNoteValue: UInt8 = 72){
        midi.sendEvent(MIDIEvent(noteOn: midiNoteValue, velocity: 80, channel: 1))
    }
    
    func sendMidiNoteOff(_ midiNoteValue: UInt8 = 72){
        midi.sendEvent(MIDIEvent(noteOn: midiNoteValue, velocity: 0, channel: 1))
    }
    
}

class PadController: ObservableObject{
    
    var rootNote: UInt8 = 72
    
    /// value is -1 on setup
    var indexSelected: Int = -1{
        willSet(newIndexSelected){
            
            // clear previous value
            if(indexSelected != newIndexSelected && indexSelected != -1){
                pads[indexSelected].isOn = false
            }
            
            // set new value
            if(indexSelected != newIndexSelected && newIndexSelected != -1){
                pads[newIndexSelected].isOn = true
            }
            
        }
        
    }
    
    public var pads : [PadModel] = []
    
    init(){
        createPads()
    }
    
    func createPads(_ numberOfPadsToCreate: UInt8 = 12){
        pads = []
        for i in 0...numberOfPadsToCreate-1{
            let noteNumber = rootNote + i
            let pad = PadModel(noteNumber: noteNumber)
            pads.append(pad)
        }
    }
    
}

class PadModel: ObservableObject{
    var noteID: UInt8 = 72
    @Published var isOn: Bool = false{
        didSet{
            if(isOn){
                onCallback()
            }else{
                offCallback()
            }
        }
    }
    
    init(){}
    init(noteNumber: UInt8){
        noteID = noteNumber
    }
    
    func onCallback(){
        Conductor.shared.sendMidiNoteOn(noteID)
        Conductor.shared.objectWillChange.send()
        print("Note On: " + String(noteID) )
    }
    func offCallback(){
        Conductor.shared.sendMidiNoteOff(noteID)
        Conductor.shared.objectWillChange.send()
        print("Note Off: " + String(noteID) )
    }
}
