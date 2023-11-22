//
//  ViewController.swift
//  umbra
//
//  Created by Turker Nessa Kucuk on 11/15/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var testButton: UmbraButton!
    
    //Has shadows
    @IBOutlet private weak var hasShadowsSwitch: UISwitch!
    
    //color picker
    @IBOutlet private weak var shadowColorPicker: UIColorWell!
    
    //offset
    @IBOutlet private weak var xOffsetSlider: UISlider!
    @IBOutlet private weak var xOffsetValue: UILabel!
    @IBOutlet private weak var yOffsetSlider: UISlider!
    @IBOutlet private weak var yOffsetValue: UILabel!
    
    //opacity
    @IBOutlet private weak var opacitySlider: UISlider!
    @IBOutlet private weak var opacityValue: UILabel!
    
    //blur
    @IBOutlet private weak var blurSlider: UISlider!
    @IBOutlet private weak var blurValue: UILabel!
    
    //blur
    @IBOutlet private weak var cornerStyle: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testButton.shadowColor = .black
        shadowColorPicker.addTarget(self, action: #selector(colorChanged(_:)), for: .valueChanged)
        shadowColorPicker.selectedColor = .black
        
        testButton.shadowOffset = CGPoint(x: 2, y: 2)
        xOffsetSlider.value = 2.0
        xOffsetValue.text = "2.0"
        
        yOffsetSlider.value = 2.0
        yOffsetValue.text = "2.0"
        
        testButton.shadowOpacity = 0.5
        opacitySlider.value = 50.0
        opacityValue.text = "50%"
        
        testButton.shadowBlurRadius = 2.0
        blurSlider.value = 2.0
        blurValue.text = "2.0"
        
        //testButton.layer.setAffineTransform(.init(scaleX: 2.0, y: 2.0))
    }
    
    @IBAction private func didChangeSwitch(_ sender: UISwitch) {
        testButton.hasShadows = sender.isOn
    }
    
    @objc private func colorChanged(_ sender: UIColorWell) {
        testButton.shadowColor = sender.selectedColor ?? .darkGray
    }
    
    @IBAction private func cornerStyleChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            testButton.configuration?.cornerStyle = .fixed
        case 1:
            testButton.configuration?.cornerStyle = .dynamic
        case 2:
            testButton.configuration?.cornerStyle = .small
        case 3:
            testButton.configuration?.cornerStyle = .medium
        case 4:
            testButton.configuration?.cornerStyle = .large
        default:
            testButton.configuration?.cornerStyle = .capsule
        }
    }

    @IBAction private func didChangeSlider(_ sender: UISlider) {
        
        switch sender.tag {
        case 0:
            //offset x
            let roundedSliderValue = sender.value.rounded()
            xOffsetValue.text = String(roundedSliderValue)
            testButton.shadowOffset = CGPoint(x: CGFloat(roundedSliderValue), y: testButton.shadowOffset.y)
        case 1:
            //offset y
            let roundedSliderValue = sender.value.rounded()
            yOffsetValue.text = String(roundedSliderValue)
            testButton.shadowOffset = CGPoint(x: testButton.shadowOffset.x, y: CGFloat(roundedSliderValue))
        case 2:
            //opacity (value are percentage points)
            let roundedSliderValue = sender.value.rounded()
            opacityValue.text = String(Int(roundedSliderValue)) + "%"
            testButton.shadowOpacity = Double(roundedSliderValue)/100.0
        default:
            //blur
            //its values can be between 0 and 12 - where 1.5 is also a legitimate value
            let roundedValue = round(Double(sender.value), toNearest: 0.5)
            blurValue.text = String(roundedValue)
            testButton.shadowBlurRadius = CGFloat(roundedValue)
        }
    }
    
    func round(_ value: Double, toNearest: Double) -> Double {
        return Darwin.round(value / toNearest) * toNearest
    }
}

