//
//  ViewController.swift
//  FancySynth
//
//  Created by Pedro Moreno on 08/10/2021.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    var oscillator: Oscillator!
    var octave = 4
    var notes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
    let OFFSET = 12
    @IBOutlet var octaveLabel: UILabel!
    
    var demoMenu: UIMenu {
        return UIMenu(title: "Waveform", image: nil, identifier: nil, children: menuItems)
    }
    
    @IBOutlet var showMenuButton: UIButton!
    
    
    @IBOutlet var amplitudeKnob: ImageKnob!
    @IBOutlet var rampKnob: ImageKnob!
    @IBOutlet var glideKnob: ImageKnob!
    
    //Buttons
    @IBOutlet var c1Button: UIButton!
    @IBOutlet var d1Button: UIButton!
    @IBOutlet var e1Button: UIButton!
    @IBOutlet var f1Button: UIButton!
    @IBOutlet var g1Button: UIButton!
    @IBOutlet var a1Button: UIButton!
    @IBOutlet var b1Button: UIButton!
    @IBOutlet var c2Button: UIButton!
    @IBOutlet var d2Button: UIButton!
    @IBOutlet var e2Button: UIButton!
    @IBOutlet var f2Button: UIButton!
    @IBOutlet var g2Button: UIButton!
    @IBOutlet var a2Button: UIButton!
    @IBOutlet var b2Button: UIButton!
    @IBOutlet var c3Button: UIButton!
    
    @IBOutlet var cS1Button: UIButton!
    @IBOutlet var dS1Button: UIButton!
    @IBOutlet var fS1Button: UIButton!
    @IBOutlet var gS1Button: UIButton!
    @IBOutlet var aS1Button: UIButton!
    @IBOutlet var cS2Button: UIButton!
    @IBOutlet var dS2Button: UIButton!
    @IBOutlet var fS2Button: UIButton!
    @IBOutlet var gS2Button: UIButton!
    @IBOutlet var aS2Button: UIButton!
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Sine", image: UIImage(named: "sineWave"), handler: { (_) in
                print("SINE SELECTED")
                self.showMenuButton.setTitle("Sine", for: .normal)
                self.oscillator.changeWaveform(tag: 1)
            }),
            UIAction(title: "Square", image: UIImage(named: "squareWave"), handler: { (_) in
                print("SQUARE SELECTED")
                self.showMenuButton.setTitle("Square", for: .normal)
                self.oscillator.changeWaveform(tag: 2)
            }),
            UIAction(title: "Triangle", image: UIImage(named: "triangleWave"), handler: { (_) in
                print("TRIANGLE SELECTED")
                self.showMenuButton.setTitle("Triangle", for: .normal)
                self.oscillator.changeWaveform(tag: 3)
            }),
            UIAction(title: "Sawtooth", image: UIImage(named: "sawtoothWave"), handler: { (_) in
                print("SAWTOOTH SELECTED")
                self.showMenuButton.setTitle("Sawtooth", for: .normal)
                self.oscillator.changeWaveform(tag: 4)
            })
        ]
    }
    
    override func viewDidLoad() { 
        
        super.viewDidLoad()
        
        oscillator = Oscillator()
        setUpCallBacks()
        oscillator.start()
        currentNotes()
        configureButtonMenu()
        oscillator.changeWaveform(tag: 1)
        showMenuButton.setTitle("Sine", for: .normal)
        overrideUserInterfaceStyle = .dark
        
    }
    
    func setUpButtons() {
        c1Button.setTitle("", for: .normal)
        d1Button.setTitle("", for: .selected)
        e1Button.setTitle("", for: .normal)
        f1Button.setTitle("", for: .normal)
        g1Button.setTitle("", for: .normal)
        a1Button.setTitle("", for: .normal)
        b1Button.setTitle("", for: .normal)
        c2Button.setTitle("", for: .normal)
        d2Button.setTitle("", for: .normal)
        e2Button.setTitle("", for: .normal)
        f2Button.setTitle("", for: .normal)
        g2Button.setTitle("", for: .normal)
        a2Button.setTitle("", for: .normal)
        b2Button.setTitle("", for: .normal)
        c3Button.setTitle("", for: .normal)
        
        cS1Button.setTitle("", for: .selected)
        cS1Button.layer.borderWidth = 0.0
        
        dS1Button.setTitle("", for: .normal)
        fS1Button.setTitle("", for: .normal)
        gS1Button.setTitle("", for: .normal)
        aS1Button.setTitle("", for: .normal)
        cS2Button.setTitle("", for: .normal)
        dS2Button.setTitle("", for: .normal)
        fS2Button.setTitle("", for: .normal)
        gS2Button.setTitle("", for: .normal)
        aS2Button.setTitle("", for: .normal)
        
    }
    
    @IBAction func playKey(_ sender: UIButton) {
        let noteValue = MIDINoteNumber(notes[sender.tag])
        oscillator.noteOn(note: noteValue)
        keyPressedImage(sender)
    }
    func keyPressedImage(_ sender: UIButton){
        switch sender.tag {
        case 0, 12, 5, 17:
            sender.setImage(UIImage(named: "cPressed"), for: .normal)
        case 2, 14:
            sender.setImage(UIImage(named: "dPressed"), for: .normal)
        case 4, 11, 16, 23:
            sender.setImage(UIImage(named: "ePressed"), for: .normal)
        case 7, 19:
            sender.setImage(UIImage(named: "gPressed"), for: .normal)
        case 9, 21:
            sender.setImage(UIImage(named: "aPressed"), for: .normal)
        case 1, 13, 3, 15, 6, 18, 8, 20, 10, 22:
            sender.setImage(UIImage(named: "sharpPressed"), for: .normal)
        case 24:
            sender.setImage(UIImage(named: "c3Pressed"), for: .normal)
        default:
            print("Error: that button doesn't correspond to a key")
        }
    }
    @IBAction func stopKey(_ sender: UIButton) {
        let noteValue = MIDINoteNumber(notes[sender.tag])
        oscillator.noteOff(note: noteValue)
        keyReleasedImage(sender)
    }
    
    func keyReleasedImage(_ sender: UIButton){
        switch sender.tag {
        case 0, 12, 5, 17:
            sender.setImage(UIImage(named: "cNotPressed"), for: .normal)
        case 2, 14:
            sender.setImage(UIImage(named: "dNotPressed"), for: .normal)
        case 4, 11, 16, 23:
            sender.setImage(UIImage(named: "eNotPressed"), for: .normal)
        case 7, 19:
            sender.setImage(UIImage(named: "gNotPressed"), for: .normal)
        case 9, 21:
            sender.setImage(UIImage(named: "aNotPressed"), for: .normal)
        case 1, 13, 3, 15, 6, 18, 8, 20, 10, 22:
            sender.setImage(UIImage(named: "sharpNotPressed"), for: .normal)
        case 24:
            sender.setImage(UIImage(named: "c3NotPressed"), for: .normal)
        default:
            print("Error: that button doesn't correspond to a key")
        }
    }
    
    func configureButtonMenu() {
        showMenuButton.menu = demoMenu
        showMenuButton.showsMenuAsPrimaryAction = true
    }
    
    func currentNotes(){
        for i in notes.indices {
         //   let i = notes.firstIndex(of: note)
            notes[i] = (octave + 1) * OFFSET + i
        }
    }
    
    @IBAction func changeOct(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            octave -= 1
        case 1:
            octave += 1
        default:
            print("ERROR: wrong tag for octave buttons")
        }
        octaveLabel.text = String(octave)
        
        currentNotes()
    }
   
    @IBAction func glideOnOff(_ sender: UISwitch) {
        oscillator.isGlideOn = sender.isOn
    }
    
    func setUpCallBacks(){
        amplitudeKnob.callback = { [self] value in
            self.oscillator.amplitude = AUValue(value)
        }
        
        rampKnob.callback = { [self] value in
            self.oscillator.ramp = AUValue(value)
        }
        
        glideKnob.callback = { [self] value in
            self.oscillator.glide = AUValue(value)
        }
    }
}

