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
    @IBOutlet weak var nextButton: UIButton!
    
    var quotes = [Quote]()
    
    var currentQuote = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Disable this until we've loaded the quotes
        nextButton.enabled = false
        
        refreshQuotes()
    }
    
    func setNextQuote() {
        
        let quote = quotes[currentQuote % quotes.count]
        
        quoteTextView.text = quote.text
        currentQuote += 1
    }
    
    func refreshQuotes() {
        
        Alamofire.request(.GET, "http://calebmennen.com:5000/todo/api/v1.0/tasks")
            .responseJSON { response in
                
                // Attempt to cast our json as a dicationay, then grab the array of quotes, then create the quotes
                if let
                    json = response.result.value as? NSDictionary,
                    quotesJSON = json["tasks"] as? NSArray,
                    quotes = Quote.from(quotesJSON)
                {
                    // Save those quotes
                    self.quotes = quotes
                    // Set the first quote
                    self.setNextQuote()
                    // Enable the next button
                    self.nextButton.enabled = true
                }
                else {
                    /*
                     In this case, there was a networking error and we print it,
                     or we couldn't cast the json as a dict then grab the array,
                     so something is wrong with the json if this prints nil
                    */
                    print(response.result.error?.localizedDescription)
                    self.quoteTextView.text = "no quotes for u ☹️"
                }
        }
    }
    
    @IBAction func nextQuoteButtonPressed(sender: AnyObject) {
        setNextQuote()
    }
}

