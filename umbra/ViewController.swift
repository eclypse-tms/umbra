//
//  ViewController.swift
//  umbra
//
//  Created by Turker Nessa Kucuk on 11/15/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var testButton: UmbraButton!
    @IBOutlet private weak var testButtonOldApi: UmbraButtonOldApi!
    
    //Has shadows
    @IBOutlet private weak var hasShadowSwitch: UISwitch!
    
    //use new api switch
    @IBOutlet private weak var useNewApiSwitch: UISwitch!
    
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
    
    //corner radius (used for old api)
    @IBOutlet private weak var cornerRadiusStack: UIStackView!
    @IBOutlet private weak var cornerRadiusSlider: UISlider!
    @IBOutlet private weak var cornerRadiusValue: UILabel!
    
    //corner style (used in the new api)
    @IBOutlet private weak var cornerStyleStack: UIStackView!
    @IBOutlet private weak var cornerStyle: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if useNewApiSwitch.isOn {
            resetUIForTestButton()
        } else {
            resetUIForTestButtonWithOldApi()
        }
        
        addTargetToColorWell()
        
        testButton.isHidden = !useNewApiSwitch.isOn
        testButtonOldApi.isHidden = useNewApiSwitch.isOn
        cornerStyleStack.isHidden = !useNewApiSwitch.isOn
        cornerRadiusStack.isHidden = useNewApiSwitch.isOn
        
    }
    
    private func addTargetToColorWell() {
        shadowColorPicker.addTarget(self, action: #selector(colorChanged(_:)), for: .valueChanged)
    }
    
    private func resetUIForTestButton() {
        cornerStyle.selectedSegmentIndex = 0
        
        testButton.hasShadow = true
        hasShadowSwitch.isOn = true
        
        testButton.shadowColor = .black
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
    }
    
    private func resetUIForTestButtonWithOldApi() {
        testButtonOldApi.hasShadow = true
        hasShadowSwitch.isOn = true
        
        testButtonOldApi.shadowColor = .black
        shadowColorPicker.selectedColor = .black
        
        testButtonOldApi.shadowOffset = CGPoint(x: 2, y: 2)
        xOffsetSlider.value = 2.0
        xOffsetValue.text = "2.0"
        
        yOffsetSlider.value = 2.0
        yOffsetValue.text = "2.0"
        
        testButtonOldApi.shadowOpacity = 0.5
        opacitySlider.value = 50.0
        opacityValue.text = "50%"
        
        testButtonOldApi.shadowBlurRadius = 2.0
        blurSlider.value = 2.0
        blurValue.text = "2.0"
        
        testButtonOldApi.cornerRadius = 2.0
        cornerRadiusSlider.value = 2
        cornerRadiusValue.text = "2.0"
    }
    
    @IBAction private func didChangeSwitch(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            //has shadow switch
            if useNewApiSwitch.isOn {
                testButton.hasShadow = sender.isOn
            } else {
                testButtonOldApi.hasShadow = sender.isOn
            }
        default:
            //use new api switch
            testButton.isHidden = !useNewApiSwitch.isOn
            testButtonOldApi.isHidden = useNewApiSwitch.isOn
            
            cornerStyleStack.isHidden = !useNewApiSwitch.isOn
            cornerRadiusStack.isHidden = useNewApiSwitch.isOn
            
            if sender.isOn {
                //use new api
                resetUIForTestButton()
            } else {
                //use old api
                resetUIForTestButtonWithOldApi()
            }
        }
    }
    
    @objc private func colorChanged(_ sender: UIColorWell) {
        if useNewApiSwitch.isOn {
            testButton.shadowColor = sender.selectedColor ?? .darkGray
        } else {
            testButtonOldApi.shadowColor = sender.selectedColor ?? .darkGray
        }
    }
    
    // only used with the button that uses the UIButton.Configuration api
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
            if useNewApiSwitch.isOn {
                testButton.shadowOffset = CGPoint(x: CGFloat(roundedSliderValue), y: testButton.shadowOffset.y)
            } else {
                testButtonOldApi.shadowOffset = CGPoint(x: CGFloat(roundedSliderValue), y: testButtonOldApi.shadowOffset.y)
            }
        case 1:
            //offset y
            let roundedSliderValue = sender.value.rounded()
            yOffsetValue.text = String(roundedSliderValue)
            if useNewApiSwitch.isOn {
                testButton.shadowOffset = CGPoint(x: testButton.shadowOffset.x, y: CGFloat(roundedSliderValue))
            } else {
                testButtonOldApi.shadowOffset = CGPoint(x: testButtonOldApi.shadowOffset.x, y: CGFloat(roundedSliderValue))
            }
        case 2:
            //opacity (value are percentage points)
            let roundedSliderValue = sender.value.rounded()
            opacityValue.text = String(Int(roundedSliderValue)) + "%"
            if useNewApiSwitch.isOn {
                testButton.shadowOpacity = Double(roundedSliderValue)/100.0
            } else {
                testButtonOldApi.shadowOpacity = Double(roundedSliderValue)/100.0
            }
        case 3:
            //blur
            //its values can be between 0 and 12 - where 1.5 is also a legitimate value
            let roundedValue = round(Double(sender.value), toNearest: 0.5)
            blurValue.text = String(roundedValue)
            if useNewApiSwitch.isOn {
                testButton.shadowBlurRadius = CGFloat(roundedValue)
            } else {
                testButtonOldApi.shadowBlurRadius = CGFloat(roundedValue)
            }
        default:
            //corner radius (used by the old api)
            let roundedSliderValue = sender.value.rounded()
            cornerRadiusValue.text = String(roundedSliderValue)
            testButtonOldApi.cornerRadius = CGFloat(roundedSliderValue)
        }
    }
    
    func round(_ value: Double, toNearest: Double) -> Double {
        return Darwin.round(value / toNearest) * toNearest
    }
}

