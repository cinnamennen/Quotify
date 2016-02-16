//
//  ViewController.swift
//  myProduct
//
//  Created by Caleb on 1/24/16.
//  Copyright © 2016 Caleb. All rights reserved.
//

import UIKit
import EasyAnimation
import Starscream
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var quoteTextView: UITextView!
    let quotes = ["I love IRC - kylebshr", "Can we use slack? - jaredmsmith", "What are you talking about? - joecon"]
    
    var currentQuote = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setNextQuote()
    }
    
    func setNextQuote() {
        quoteTextView.text = quotes[currentQuote % quotes.count]
        currentQuote += 1
    }
    @IBAction func nextQuoteButtonPressed(sender: AnyObject) {
        setNextQuote()
    }
}

