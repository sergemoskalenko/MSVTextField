//
//  MSVTextField.swift
//  MSVTextFieldExample
//
//  https://github.com/sergemoskalenko
//  Created by Serge Moskalenko on 9/29/19.
//  Copyright © 2019 Serge Moskalenko. All rights reserved.
//

import UIKit

@objc(MSVTextField) public class MSVTextField: UITextField, UITextFieldDelegate {
    private var _delegate: UITextFieldDelegate?
    override public var delegate: UITextFieldDelegate? {
        get {
            return _delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    private var onFocusAction: ((MSVTextField, Bool)->())?
    private var shouldBeginEditingAction: ((MSVTextField) -> (Bool))?
    private var shouldEndEditingAction: ((MSVTextField) -> (Bool))?
    private var shouldChangeCharactersAction: ((MSVTextField, String)->(Bool))?
    private var shouldClearAction: ((MSVTextField) -> (Bool))?
    private var shouldReturnAction: ((MSVTextField) -> (Bool))?

    convenience init() {
        self.init()
        super.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        super.delegate = self
    }
    
    @discardableResult
    public func onFocus(action: ((MSVTextField, Bool)->())?) -> MSVTextField {
        onFocusAction = action
        return self
    }
    
    @discardableResult
    public func onChange(action:((MSVTextField, String)->(Bool))?) -> MSVTextField {
        shouldChangeCharactersAction = action
        return self
    }
    
    @discardableResult
    public func shouldBeginEditing(action:((MSVTextField)->(Bool))?) -> MSVTextField {
        shouldBeginEditingAction = action
        return self
    }

    @discardableResult
    public func shouldEndEditing(action:((MSVTextField)->(Bool))?) -> MSVTextField {
        shouldEndEditingAction = action
        return self
    }
    
    @discardableResult
    public func shouldClear(action:((MSVTextField)->(Bool))?) -> MSVTextField {
        shouldClearAction = action
        return self
    }
    
    @discardableResult 
    public func shouldReturn(action:((MSVTextField)->(Bool))?) -> MSVTextField {
        shouldReturnAction = action
        return self
    }
    
    // Mark: - Additional
    
    public func focus(_ isSet: Bool = true) {
        if isSet {
            self.becomeFirstResponder()
        } else {
            self.resignFirstResponder()
        }
    }
    
    // Mark: - UITextField Delegates

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool // return NO to disallow editing.
    {
        if let shouldBeginEditing = _delegate?.textFieldShouldBeginEditing {
            return shouldBeginEditing(self)
        }
        
        if let shouldBeginEditing = shouldBeginEditingAction {
            return shouldBeginEditing(self)
        }
        
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) // became first responder
    {
        onFocusAction?(self, true)
        _delegate?.textFieldDidBeginEditing?(self)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    {
        if let shouldEndEditing = _delegate?.textFieldShouldEndEditing {
            return shouldEndEditing(self)
        }
        
        if let shouldEndEditing = shouldEndEditingAction {
            return shouldEndEditing(self)
        }
        
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    {
        onFocusAction?(self, false)
        _delegate?.textFieldDidEndEditing?(self)
    }
    
    @available(iOS 10.0, *)
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) // if implemented, called in place of textFieldDidEndEditing:
    {
        onFocusAction?(self, false)
        _delegate?.textFieldDidEndEditing?(self, reason: reason)
    }
    

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    {
        if let shouldChangeCharacters: ((UITextField, NSRange, String) -> Bool) = _delegate?.textField {
            return shouldChangeCharacters(self, range, string)
        }
        
        if let shouldChangeCharacters: ((MSVTextField, String)->(Bool)) = shouldChangeCharactersAction {
            let textFieldText: NSString = (textField.text ?? "") as NSString
            let newString = textFieldText.replacingCharacters(in: range, with: string)
            return shouldChangeCharacters(self, newString)
        }
        
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool // called when clear button pressed. return NO to ignore (no notifications)
    {
        if let shouldClear = _delegate?.textFieldShouldClear {
            return shouldClear(self)
        }
        
        if let shouldClear = shouldClearAction {
            return shouldClear(self)
        }
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        if let shouldReturn = _delegate?.textFieldShouldReturn {
            return shouldReturn(self)
        }
        
        if let shouldReturn = shouldReturnAction {
            return shouldReturn(self)
        }
        
        return true
    }

}
    

