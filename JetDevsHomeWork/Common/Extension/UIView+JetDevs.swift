//
//  UIView.swift
//  JetDevsHomeWork
//
//  Created by Harshil on 13/12/22.
//

import Foundation
import UIKit

extension UIView {
    
 
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
             
            self.layer.masksToBounds = true
        }
    }
}
