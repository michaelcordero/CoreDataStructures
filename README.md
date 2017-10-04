# CoreDataStructures

[![CI Status](http://img.shields.io/travis/michaelcordero/CoreDataStructures.svg?style=flat)](https://travis-ci.org/michaelcordero/CoreDataStructures)
[![Version](https://img.shields.io/cocoapods/v/CoreDataStructures.svg?style=flat)](http://cocoapods.org/pods/CoreDataStructures)
[![License](https://img.shields.io/cocoapods/l/CoreDataStructures.svg?style=flat)](http://cocoapods.org/pods/CoreDataStructures)
[![Platform](https://img.shields.io/cocoapods/p/CoreDataStructures.svg?style=flat)](http://cocoapods.org/pods/CoreDataStructures)

#Overview

CoreDataStructures is library of fundamental data structures written in Swift 4.0.
Actual components can be found in CoreDataStructures/CoreDataStructures/Classes/ directory.
Travis build is failing due to .travis.yml being broken as of OCT 4, 2017, will fix ASAP.

#Usage

```Swift

import UIKit
import CoreDataStructures

class WelcomeViewController: UIViewController {
    
    var xStack: Stack<Double> = Stack<Double>()
    var xBST: BinarySearchTree<Int> = BinarySearchTree<Int>()
    var xQueue: Queue<Float> = Queue<Float>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
} 
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 11.0
* Swift 4.0

## Installation

CoreDataStructures is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CoreDataStructures'
```

## Author

Michael Cordero, michaelpetercordero@gmail.com

## License

CoreDataStructures is available under the MIT license. See the LICENSE file for more info.
