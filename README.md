# MSVTextFieldPod

[![CI Status](https://img.shields.io/travis/sergemoskalenko/MSVTextFieldPod.svg?style=flat)](https://travis-ci.org/sergemoskalenko/MSVTextFieldPod)
[![Version](https://img.shields.io/cocoapods/v/MSVTextFieldPod.svg?style=flat)](https://cocoapods.org/pods/MSVTextFieldPod)
[![License](https://img.shields.io/cocoapods/l/MSVTextFieldPod.svg?style=flat)](https://cocoapods.org/pods/MSVTextFieldPod)
[![Platform](https://img.shields.io/cocoapods/p/MSVTextFieldPod.svg?style=flat)](https://cocoapods.org/pods/MSVTextFieldPod)

## Example

[![img](https://raw.githubusercontent.com/sergemoskalenko/MSVTextField/master/Example/MSVTextField.gif)](https://github.com/sergemoskalenko/MSVTextField)



To run the example project, clone the repo, and run `pod install` from the Example directory first.

There is simple task:
How to make UITextfield highlight when tapped? (On focus)

```swift
simpleTextField.onFocus { textField, isBegin in
   textField.backgroundColor = isBegin ? UIColor.yellow : UIColor.lightGray
}
```

How to check input and highlight?

```swift
simpleTextField.onFocus { textField, isBegin in
   textField.backgroundColor = isBegin ? UIColor.yellow : UIColor.lightGray
}.onChange { _, string in
   return string.count < 10 // check for 10 symbols max
}
```


## Requirements

## Installation

MSVTextFieldPod is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MSVTextFieldPod'
```

## Author

Serge Moskalenko, https://github.com/sergemoskalenko

## License

MSVTextFieldPod is available under the MIT license. See the LICENSE file for more info.
