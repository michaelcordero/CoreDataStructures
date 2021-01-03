# CoreDataStructures

[![CI Status](http://img.shields.io/travis/michaelcordero/CoreDataStructures.svg?style=flat)](https://travis-ci.org/michaelcordero/CoreDataStructures)
[![Version](https://img.shields.io/github/v/tag/michaelcordero/coredatastructures)](https://github.com/michaelcordero/CoreDataStructures/tags)
[![License](https://img.shields.io/github/license/michaelcordero/CoreDataStructures)](https://github.com/michaelcordero/CoreDataStructures/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/CoreDataStructures)](https://github.com/michaelcordero/CoreDataStructures)

## Overview

CoreDataStructures is library of fundamental data structures written in Swift 5.3, therefore xcode toolchain 12.3+ is required to build this project.
Actual components can be found in CoreDataStructures/Sources/CoreDataStructures/ directory.

## Usage

```Swift

import UIKit
import CoreDataStructures

class WelcomeViewController: UIViewController {
    
    var xStack: Stack<Double> = Stack<Double>()
    var xBST: BinarySearchTree<Int> = BinarySearchTree<Int>()
    var xQueue: Queue<Float> = Queue<Float>()
    var xLinkedList: LinkedList<Double> = LinkedList<Double>()

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

To run the example project, clone the repo, and run `swift build && swift test` from the project directory.

## Requirements

* iOS 12.0
* Swift 5.3

## Installation

CoreDataStructures is available through [github](https://github.com/michaelcordero/CoreDataStructures).
```
git clone https://github.com/michaelcordero/CoreDataStructures
```

## Author

Michael Cordero, michaelpetercordero@gmail.com

## License

CoreDataStructures is available under the MIT license. See the LICENSE file for more info.
