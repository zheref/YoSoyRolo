//
//  TranslationRecordingViewController.swift
//  YoSoyRolo
//
//  Created by Sergio Daniel Leztark on 5/30/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class TranslationRecordingViewController : UIViewController
{
    // MARK: - INSTANCE MEMBERS
    
    private var _word: String?
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad()
    {
        self.setup()
    }
    
    // MARK: - ROUTINES
    
    private func setup()
    {
        guard let word = _word else {
            return
        }
        
        self.title = "Translation for '\(word)'"
    }
    
    internal func inject(word word: String)
    {
        _word = word
    }
    
    
}
