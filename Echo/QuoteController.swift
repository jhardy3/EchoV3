//
//  QuoteController.swift
//  Echo
//
//  Created by Jake Hardy on 4/6/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import Foundation



let kContentKey = "contents"
let kQuotesKey = "quotes"
let kLengthKey = "length"
let kAuthorKey = "author"
let kQuoteKey = "quote"

class QuoteController {
    
    static let sharedInstance = QuoteController()
    
    var quotes = [(String, String, String)]()
    
    init() {
        fetchQuote { (quote) in
            if let quote = quote {
                self.quotes.append(quote)
            }
        }
    }
    
    func firstLoad(view: EchoViewController) {
        QuoteController.sharedInstance.fetchQuote { (quote) in
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

    
    func fetchQuote(completion: (quote: (quote: String, author: String, length: String)?) -> Void) {
        NetworkController.dataAtURL(quoteURL) { (returnedData) in
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
}