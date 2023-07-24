//
//  UITextField+Extension.swift
//  TravelSignUp
//
//  Created by Aung Kyaw Phyo on 7/25/23.
//

import Foundation
import UIKit

extension UITextField {
    func addRighView(imgName: String) {
        let imageView = UIImageView(image: UIImage(named: imgName))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: imageView.frame.height))
        paddingView.addSubview(imageView)
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
