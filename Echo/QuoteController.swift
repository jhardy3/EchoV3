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
    private static let imageURL = "https://unsplash.it/200/400?random"
    private static let quoteURL = NSURL(string: "http://quotes.rest/qod.json")!
    
    static func fetchQuote(completion: (quote: Quote?) -> Void) {
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
            NetworkController.fetchImageAtURL(imageURL, completion: { (image) in
                if let image = image {
                    let quote = Quote(quote: quote, image: image, author: author, length: length)
                    completion(quote: quote)
                } else {
                    completion(quote: nil)
                }
            })
            
        }
    }
}