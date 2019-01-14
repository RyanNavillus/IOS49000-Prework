//
//  EditableStepper.swift
//  tippy
//
//  Created by Ryan Sullivan on 1/8/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

protocol EditableStepperDelegate: AnyObject {
    func valueChanged(sender: EditableStepper)
}

class EditableStepper: UIView{
    
    let leftButton = HighlightButton()
    let rightButton = HighlightButton()
    let label = UILabel()
    var delegate: EditableStepperDelegate? = nil
    
    var value = 1 {
        didSet {
            label.text = String(value)
            delegate?.valueChanged(sender: self)
        }
    }
    var textColor = UIColor.lightTextColor {
        didSet {
            label.textColor = textColor
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            leftButton.setTitleColor(backgroundColor, for: .normal)
            rightButton.setTitleColor(backgroundColor, for: .normal)
            label.backgroundColor = backgroundColor

        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            leftButton.backgroundColor = tintColor
            
            rightButton.backgroundColor = tintColor
            
            layer.borderColor = tintColor.cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupStepper()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStepper()
    }
    
    func setupStepper() {
        leftButton.setTitle("-", for: .normal)
        addSubview(leftButton)
        
        rightButton.setTitle("+", for: .normal)
        addSubview(rightButton)
        
        label.text = "1"
        label.textAlignment = .center
        addSubview(label)
        
        leftButton.addTarget(self, action: #selector(subtract(button:)), for: .touchUpInside)
        
        rightButton.addTarget(self, action: #selector(add(button:)), for: .touchUpInside)
        
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        
    }
    
    override func layoutSubviews() {
        let labelWidthWeight: CGFloat = 0.3
        let buttonWidth = bounds.size.width * ((1 - labelWidthWeight) / 2)
        let buffer: CGFloat = 1
        let labelWidth = bounds.size.width * labelWidthWeight - (2 * buffer)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: bounds.size.height)
        label.frame = CGRect(x: buttonWidth + buffer, y: 0, width: labelWidth, height: bounds.size.height)
        rightButton.frame = CGRect(x: labelWidth + buttonWidth + (2 * buffer), y: 0, width: buttonWidth, height: bounds.size.height)
        
    }
    
    @objc func add(button: UIButton) {
        value += 1
    }
    
    @objc func subtract(button: UIButton) {
        if value > 1 {
            value -= 1
        }
    }
    
}

