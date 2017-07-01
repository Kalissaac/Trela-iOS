//
//  UIView+Designable.swift
//  Trela
//
//  Created by Kalissaac on 5/24/16.
//  Copyright © 2016 Kalissaac Corp. All rights reserved.
//

import UIKit

@IBDesignable class DesignableImageView: UIImageView { }

extension UIView {
  
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    
    set(newBorderWidth) {
      layer.borderWidth = newBorderWidth
    }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
    }
    
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue != 0
    }
  }
  
  @IBInspectable
  var makeCircular: Bool? {
    get {
      return nil
    }
    
    set {
      if let makeCircular = newValue, makeCircular {
        cornerRadius = min(bounds.width, bounds.height) / 2.0
      }
    }
  }
  
}

