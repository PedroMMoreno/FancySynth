//
//  ImageKnob.swift
//  Acid Me!
//
//  Created by Matthew Fecher on 9/19/17.
//  Copyright © 2017 AudioKit. All rights reserved.
//  Source: 3D Image Knob Example https://github.com/analogcode/3D-Knobs
//
//  Edited by Pedro M. Moreno on 26/12/2020.
//  ELE00083M iOS Programming for Audio.
//

import UIKit

///
/// ImageKnob handles the knob image array containing its frames. When the knob value changes, the frame will be changing as well, giving the feeling that it is rotating. For this, it is highly recommended to have a significant amount of frames per knob, and these have to be instances of the rotated knob. For more detail, check Assets.xcassets/Knobs.
///
/// - author: Matthew Fecher
/// - Date: 9/19/2017.
///
@IBDesignable public class ImageKnob: Knob {
    
    /* VARIABLES */
    
    var imageView = UIImageView()
    var imageArray = [UIImage]()
    
    /* var totalFrames */
    /// Estabilshes the number of frames of the image.
    ///
    @IBInspectable open var totalFrames: Int = 0 {
        didSet {
            createImageArray()
        }
    }
    
    /* var imageName */
    /// Estabilshes the name of the image, hence its corresponding frames.
    ///
    @IBInspectable open var imageName: String = "knob01_" {
        didSet {
            createImageArray()
        }
    }
    
    /* var currentFrame */
    /// Keeps count of the current frame to be shown.
    ///
    var currentFrame: Int {
        return Int(Double(knobValue) * Double(totalFrames))
    }
    
    /* VARIABLES */
    
    /* func layoutSubviews */
    /// Sets up the view layout: widht and height.
    ///
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.bounds.width,
            height: self.bounds.height)
    }
    
    /* func draw */
    /// Build the actual knob image.
    ///
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if imageArray.indices.contains(currentFrame) {
            imageView.image = imageArray[currentFrame]
        }
    }
    
    
    /* func init */
    /// Init
    ///
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /* func init? */
    /// Lifecycle
    ///
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /* func commonInit */
    /// Initialises the images corresponding to the frames of the knob and their references to the view.
    ///
    private func commonInit() {
        createImageArray()
        addSubview(imageView)
    }
    
    /*  func createImageArray */
    /// Creates an Image Array containing the frames of the knob.
    ///
    func createImageArray() {
        imageArray.removeAll()
        for i in 0..<totalFrames {
            guard let image = UIImage(
                named: "\(imageName)\(i)",
                in: Bundle(for: type(of: self)),
                compatibleWith: traitCollection)
                
                else {
                    continue
            }
            imageArray.append(image)
        }
        imageView.image = UIImage(named: "\(imageName)\(currentFrame)")
    }
}
