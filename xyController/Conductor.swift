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
    
    func sendMidiCC(_ ccVal: UInt8, ccNumber: UInt8 = 0, ccChannel: UInt8 = 0){
        midi.sendEvent(MIDIEvent(controllerChange: ccNumber, value: ccVal, channel: ccChannel))
    }
    
}

class PadController: ObservableObject{
    
    var xVal: Float = 0.0
    var yVal: Float = 0.0
    
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
    
    var ccVal: Int = -1{
        willSet(newCC){
            if(newCC != ccVal){
                pads[indexSelected].yValue = newCC
            }
        }
    }
    
    public var pads : [PadModel] = []
    
    init(){
        createPads()
    }
    
    func handleGestureValues(newX: Double, newY: Double){
        indexSelected = Int(ceil( Double(pads.count) * newX )) - 1
        ccVal = Int(ceil( Double(128) * newY )) - 1
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
                padOn()
            }else{
                padOff()
            }
        }
    }
    var yValue: Int = 0{
        didSet{
            if(yValue < 0){
                yValue = 0
            }
            padValChange()
        }
    }
    
    init(){
    }
    init(noteNumber: UInt8){
        noteID = noteNumber
    }
    
    func padOn(){
        Conductor.shared.sendMidiNoteOn(noteID)
        Conductor.shared.objectWillChange.send()
        print("Note On: " + String(noteID) )
    }
    func padOff(){
        Conductor.shared.sendMidiNoteOff(noteID)
        Conductor.shared.objectWillChange.send()
        print("Note Off: " + String(noteID) )
    }
    
    func padValChange(){
        Conductor.shared.sendMidiCC(UInt8(yValue))
        Conductor.shared.objectWillChange.send()
        print("CC Sent: " + String(yValue) )
    }
}
