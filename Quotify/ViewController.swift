//
//  ViewController.swift
//  myProduct
//
//  Created by Caleb on 1/24/16.
//  Copyright © 2016 Caleb. All rights reserved.
//

import UIKit
//import EasyAnimation
//import Starscream
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func swipeNext(sender: UISwipeGestureRecognizer) {
        refreshQuotes()
    }
    
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
        
        quoteLabel.text = quote.text
        authorLabel.text = quote.author
        currentQuote += 1
        
        print("Size is now \(quotes.count)")
        if (quotes.count % 4 == 0) {
            for l in quotes {
                print(l.printQuote())
            }
        }
        
    }
    
    func refreshQuotes() {
        
        Alamofire.request(.GET, "http://calebmennen.com:5000/todo/api/v1.0/tasks/1")
            .responseJSON { response in
                
                // Attempt to cast our json as a dicationay, then grab the array of quotes, then create the quotes
                if let
                    json = response.result.value as? NSDictionary,
                    quotes = Quote.from(json)
                {
                    // Save those quotes
                    self.quotes += [quotes]
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
                    self.quoteLabel.text = "no quotes for u ☹️"
                }
        }
    }
    
//    func updateTextFont(textView:UITextView) {
//        if (textView.text.isEmpty || CGSizeEqualToSize(textView.bounds.size, CGSizeZero)) {
//            return;
//        }
//        
//        let textViewSize = textView.frame.size;
//        let fixedWidth = textViewSize.width;
//        let expectSize = textView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat(MAXFLOAT)));
//        
//        var expectFont = textView.font;
//        if (expectSize.height > textViewSize.height) {
//            while (textView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat(MAXFLOAT))).height > textViewSize.height) {
//                expectFont = textView.font!.fontWithSize(textView.font!.pointSize - 1)
//                textView.font = expectFont
//            }
//        }
//        else {
//            while (textView.sizeThatFits(CGSizeMake(fixedWidth, CGFloat(MAXFLOAT))).height < textViewSize.height) {
//                expectFont = textView.font;
//                textView.font = textView.font!.fontWithSize(textView.font!.pointSize + 1)
//            }
//            textView.font = expectFont;
//        }
//    }
    
    @IBAction func nextQuoteButtonPressed(sender: AnyObject) {
        refreshQuotes()
        
    }
}

