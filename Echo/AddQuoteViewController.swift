//
//  AddQuoteViewController.swift
//  Echo
//
//  Created by Jake Hardy on 4/12/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class AddQuoteViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var viewQuoteButton: UIButton!
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var authorTextLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
//        self.quoteTextView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewQuoteButtonTapped(sender: UIButton) {
        guard let quote = quoteTextView.text, author = authorTextLabel.text
            where quote.isEmpty == false && author.isEmpty == false else { return }
        QuoteController.sharedInstance.addQuote(quote, author: author)
        textFieldShouldReturn(authorTextLabel)
        self.revealViewController().revealToggle(self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupView() {
        quoteTextView.layer.cornerRadius = 7.0
        quoteTextView.clipsToBounds = true
        viewQuoteButton.tintColor = UIColor.whiteColor()
        viewQuoteButton.setImage(UIImage(named: "arrow")?.imageWithColor(UIColor.whiteColor()), forState: .Normal)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
