//
//  WordSelectionPresenter.swift
//  YoSoyRolo
//
//  Created by Sergio Daniel Leztark on 5/30/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal protocol IWordSelectionPresenter
{
    var suggestions: [String] { get }
    
    func refreshAutocompletionSuggestions(forText text: String)
}

internal class WordSelectionPresenter : IWordSelectionPresenter
{
    private var _suggestions: [String] = []
    
    internal var suggestions: [String] {
        return _suggestions
    }
    
    internal func refreshAutocompletionSuggestions(forText text: String)
    {
        let checker = UITextChecker()
        let results = checker.completionsForPartialWordRange(NSMakeRange(0, text.characters.count),
                                                             inString: text, language: "en")
        
        if let suggestions = results as! [String]? {
            _suggestions = suggestions
        }
    }
    
}
