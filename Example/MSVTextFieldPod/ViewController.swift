//
//  ViewController.swift
//  MSVTextFieldExample
//
//  https://github.com/sergemoskalenko
//  Created by Serge Moskalenko on 9/29/19.
//  Copyright © 2019 Serge Moskalenko. All rights reserved.
//

import UIKit
import MSVTextFieldPod

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var simpleTextField: MSVTextField!
    @IBOutlet weak var digitsTextField: MSVTextField!
    
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgColor = simpleTextField.backgroundColor
        
        // simpleTextField.delegate = self // you can use standard delegate too
        
        simpleTextField.onFocus {textField, isBegin in
            textField.backgroundColor = isBegin ? UIColor.yellow : self.bgColor
            }.onChange { _, string in
                let validationSet = CharacterSet.decimalDigits.inverted
                let components = string.components(separatedBy: validationSet)
                let newString = components.joined(separator: "")
                return newString.count == 0
        }
        
//        simpleTextField.onFocus { textField, isBegin in
//            textField.backgroundColor = isBegin ? UIColor.yellow : UIColor.lightGray
//            }.onChange { _, string in
//                return string.count < 10 // check for 10 symbols max
//        }

        
        digitsTextField.onFocus {textField, isBegin in
            textField.backgroundColor = isBegin ? UIColor.yellow : self.bgColor
            }.onChange { _, string in
                let validationSet = CharacterSet.decimalDigits
                let components = string.components(separatedBy: validationSet)
                let newString = components.joined(separator: "")
                return newString.count == 0
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) // became first responder
    {
        textField.backgroundColor = UIColor.red
    }
}

