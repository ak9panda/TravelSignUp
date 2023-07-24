//
//  BottomBorderTextField.swift
//  TravelSignUp
//
//  Created by Aung Kyaw Phyo on 7/25/23.
//

import Foundation
import UIKit

@IBDesignable
class BottomBorderTextField: UITextField {
    
    @IBInspectable var borderColor: UIColor = UIColor.lightGray {
        didSet {
            updateBorder()
        }
    }
    
    private let borderLayer = CALayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBorderLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBorderLayer()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupBorderLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBorder()
    }
    
    private func setupBorderLayer() {
        borderStyle = .none
        borderLayer.borderWidth = 0.5
        borderLayer.borderColor = borderColor.cgColor
        layer.addSublayer(borderLayer)
    }
    
    private func updateBorder() {
        borderLayer.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
        borderLayer.borderColor = borderColor.cgColor
    }
}
