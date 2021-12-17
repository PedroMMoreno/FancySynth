//
//  Oscillator.swift
//  FancySynth
//
//  Created by Pedro Moreno on 08/10/2021.
//

import Foundation
import AudioKit
import SoundpipeAudioKit
import SwiftUI
import AudioToolbox

struct OscillatorData {
    var isPlaying: Bool = false
    var frequency: AUValue = 440
    var amplitude: AUValue = 0.1 //0-1
    var rampDuration: AUValue = 1
}

public class Oscillator {
    
    var osc = DynamicOscillator()
    let engine = AudioEngine()
    var amplitude: Float = 0.5
    var ramp: Float = 0.2
    var glide: Float = 0.2
    var isGlideOn = false
    
    @Published var data = OscillatorData() {
        didSet {
            if data.isPlaying {
                osc.start()
                if isGlideOn {
                    osc.$frequency.ramp(to: data.frequency, duration: glide)
                } else {
                    osc.$frequency.ramp(to: data.frequency, duration: 0)
                }
                osc.$amplitude.ramp(to: amplitude, duration: ramp)
            } else {
                osc.amplitude = 0.0
            }
        }
    }

    init() {
        engine.output = osc
        osc.amplitude = amplitude
    }
    
    
    func noteOn(note: MIDINoteNumber) {
        data.isPlaying = true
        data.frequency = note.midiNoteToFrequency()
    }
    
    
    func noteOff(note: MIDINoteNumber) {
        data.isPlaying = false
    }
  
    func start() {
        osc.amplitude = 0.2
        do {
            try engine.start()
        } catch let err {
            Log(err)
        }
    }
    
    func stop() {
        data.isPlaying = false
        osc.stop()
        engine.stop()
    }
    
    func changeWaveform(tag: Int){
        switch tag {
        case 1:
            osc.setWaveform(Table(.sine))
        case 2:
            osc.setWaveform(Table(.triangle))
        case 3:
            osc.setWaveform(Table(.square))
        case 4:
            osc.setWaveform(Table(.sawtooth))
        default:
            print("ERROR: that waveform doesn't exist.")
        }
    }    
}
