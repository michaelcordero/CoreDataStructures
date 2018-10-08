//
//  WelcomeViewController.swift
//  CoreDataStructures_Example
//
//  Created by Michael Cordero on 10/1/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

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
