//
//  HighlightButton.swift
//  tippy
//
//  Created by Ryan Sullivan on 1/9/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

class HighlightButton: UIButton {

    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? self.tintColor.withAlphaComponent(0.3) : self.tintColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init () {
        super.init(frame: CGRect.zero)
    }

}
