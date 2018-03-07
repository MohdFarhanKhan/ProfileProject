//
//  Designable.swift
//  ProfileProject
//
//  Created by Mohd Farhan Khan on 1/28/18.
//  Copyright © 2018 Mohd Farhan Khan. All rights reserved.
//

import UIKit

@IBDesignable class DesignableImageView: UIImageView { }
@IBDesignable class DesignableButton:UIButton { }
//@IBDesignable class DesignableTextField:UITextField { }

extension UIView {
    @IBInspectable
    var borderWidth :CGFloat {
        get {
            return layer.borderWidth
        }
        
        set(newBorderWidth){
            layer.borderWidth = newBorderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get{
           
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) :nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius :CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue != 0
        }
    }
    
  //  @IBInspectable
    var makeCircular:Bool {
        get{
            return true
        }
        
        set {
            
                cornerRadius = min(bounds.width, bounds.height) / 2.0
            
        }
    }
}
