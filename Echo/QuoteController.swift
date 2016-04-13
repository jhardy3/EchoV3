//
//  QuoteController.swift
//  Echo
//
//  Created by Jake Hardy on 4/6/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation
import UIKit


let QUOTE_KEY = "5C67osD_v4CRLx_Eb6C4igeF"
let kContentKey = "contents"
let kQuotesKey = "quotes"
let kLengthKey = "length"
let kAuthorKey = "author"
let kQuoteKey = "quote"

class QuoteController {
    
    static let sharedInstance = QuoteController()
    
    var quotes = [(quote: String, author: String, length: String)]()
    var index = 0
    var quoteLabel: UILabel!
    var view: EchoViewController!
    
    init() {
        fetchQuote(quoteURL) { (quote) in
            if let quote = quote {
                self.quotes.append(quote)
            }
        }
    }
    
    func addQuote(quote: String, author: String) {
        let length = String(quote.characters.count)
        self.quotes.insert((quote: quote, author: author, length: length), atIndex: index)
        
        let quote = quotes[index]
        quoteLabel.text = "\(quote.quote) \n - \(quote.author)"
        quoteLabel.frame.size.height = view.view.frame.height
        
        view.quoteView.center = view.view.center
        quoteLabel.center.x = view.quoteView.frame.width / 2
        quoteLabel.center.y = view.quoteView.frame.height / 2

    }
    
    func firstLoad(view: EchoViewController) {
        quoteLabel = view.quoteLabel
        self.view = view
        QuoteController.sharedInstance.fetchQuote(quoteURL) { (quote) in
            guard let quote = quote else { return }
            QuoteController.sharedInstance.quotes.insert(quote, atIndex: 0)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                view.quoteLabel.text = "\(quote.quote) \n -\(quote.author)"
            })
            
        }
        
        NetworkController.fetchImageAtURL(imageURL) { (image) in
            guard let image = image else { return }
            ImageController.sharedInstance.images.insert(image, atIndex: 0)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                view.backgroundImage.image = image
            })
            
        }
    }
    
    func fetchQuotes() {
        for _ in 0...10 {
            fetchRandomQuote(randomQuoteURL) { (quote) in
                if let quote = quote {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                      self.quotes.append(quote)
                    })
                }
            }
        }
    }
    
    func fetchOneQuote() {
        fetchRandomQuote(randomQuoteURL) { (quote) in
            if let quote = quote {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.quotes.append(quote)
                })
            }
        }
    }
    
    func indexNearEnd(index: Int) {
        if index == quotes.count - 5 {
            fetchQuotes()
        } else {
            fetchOneQuote()
        }
    }
    
    func fetchNextQuote() {
        indexNearEnd(index)
        index = index + 1
        
        if index < quotes.count {
            let quote = quotes[index]
            quoteLabel.text = "\(quote.quote) \n -\(quote.author)"
            quoteLabel.frame.size.height = view.view.frame.height
            
            view.quoteView.center = view.view.center
            quoteLabel.center.x = view.quoteView.frame.width / 2
            quoteLabel.center.y = view.quoteView.frame.height / 2
        }
    }
    
    func fetchPreviousQuote() {
        if index == 0 {
            let quote = quotes[index]
            quoteLabel.text = "\(quote.quote) \n -\(quote.author)"
        } else {
            index = index - 1
            let quote = quotes[index]
            quoteLabel.text = "\(quote.quote) \n -\(quote.author)"
            quoteLabel.frame.size.height = view.view.frame.height
            
            view.quoteView.center = view.view.center
            quoteLabel.center.x = view.quoteView.frame.width / 2
            quoteLabel.center.y = view.quoteView.frame.height / 2
        }
    }
    
    func fetchQuote(url: NSURL, completion: (quote: (quote: String, author: String, length: String)?) -> Void) {
        NetworkController.dataAtURL(url) { (returnedData) in
            guard let quoteData = returnedData,
                let quoteJSON = try? NSJSONSerialization.JSONObjectWithData(quoteData, options: .AllowFragments)
                else { return }
            guard let quoteDictionary = quoteJSON as? [String : AnyObject] else { completion(quote: nil) ; return }
            guard let quoteContentDictionary = quoteDictionary[kContentKey] as? [String : AnyObject] else { completion(quote: nil) ; return }
            guard let quoteFinalDictionary = quoteContentDictionary[kQuotesKey] as? [[String : AnyObject]] else { completion(quote: nil) ; return }
            guard let quote = quoteFinalDictionary[0][kQuoteKey] as? String  else { completion(quote: nil) ; return }
            guard let length = quoteFinalDictionary[0][kLengthKey] as? String else { completion(quote: nil) ; return }
            guard let author = quoteFinalDictionary[0][kAuthorKey] as? String else { completion(quote: nil) ; return }
            
            completion(quote: (quote: quote, author: author, length: length))
            
        }
    }
    
    func fetchRandomQuote(url: NSURL, completion: (quote: (quote: String, author: String, length: String)?) -> Void) {
        NetworkController.dataAtURL(url) { (returnedData) in
            guard let quoteData = returnedData,
                let quoteJSON = try? NSJSONSerialization.JSONObjectWithData(quoteData, options: .AllowFragments)
                else { return }
            guard let quoteDictionary = quoteJSON as? [String : AnyObject] else { completion(quote: nil) ; return }
            guard let quoteContentDictionary = quoteDictionary[kContentKey] as? [String : AnyObject] else { completion(quote: nil) ; return }
            
            guard let quote = quoteContentDictionary[kQuoteKey] as? String  else { completion(quote: nil) ; return }
            guard let author = quoteContentDictionary[kAuthorKey] as? String else { completion(quote: nil) ; return }
            
            completion(quote: (quote: quote, author: author, length: "100"))
            
        }
    }
}