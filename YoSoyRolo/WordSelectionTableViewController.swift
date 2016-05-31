//
//  WordSelectionTableViewController.swift
//  YoSoyRolo
//
//  Created by Sergio Daniel Leztark on 5/30/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class WordSelectionTableViewController : UITableViewController, UISearchResultsUpdating
{
    // MARK: - LOCAL CONSTANTS
    
    let REUSE_CELL_IDENTIFIER = "WordSuggestionCell"
    let WORD_SELECTION_TO_TRANSLATION_RECORDING_SEGUE = "WordSelectionToTranslationRecording"
    
    // MARK: - OUTLETS
    
    // MARK: - INSTANCE MEMBERS
    
    private var _searchController: UISearchController?
    
    private var _presenter: IWordSelectionPresenter
    
    private var _lastSelectedWord: String?
    
    // MARK: - INITIALIZERS
    
    required init?(coder aDecoder: NSCoder)
    {
        _presenter = WordSelectionPresenter()
        super.init(coder: aDecoder)
    }
    
    // MARK: - LIFECYCLE
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setup()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == WORD_SELECTION_TO_TRANSLATION_RECORDING_SEGUE {
            if let controller = segue.destinationViewController as? TranslationRecordingViewController {
                if let lastSelectedWord = _lastSelectedWord {
                    controller.inject(word: lastSelectedWord)
                } else {
                    SimplePopup.alert("ERROR 111", from: self)
                }
            }
        }
    }
    
    // MARK: - ROUTINES
    
    private func setup()
    {
        setupSearch()
    }
    
    internal func setupForTest()
    {
        
    }
    
    private func setupSearch()
    {
        _searchController = UISearchController(searchResultsController: nil)
        _searchController?.searchResultsUpdater = self
        _searchController?.dimsBackgroundDuringPresentation = false
        
        _searchController?.searchBar.returnKeyType = .Continue
        _searchController?.searchBar.translucent = true
        _searchController?.searchBar.searchBarStyle = .Minimal
        _searchController?.searchBar.placeholder = "Type..."
        
        self.tableView.tableHeaderView = _searchController?.searchBar
        self.definesPresentationContext = true
    }
    
    private func createSectionHeaderWithText(text: String) -> UIView
    {
        let view = UIView()
        let label = UILabel()
        
        label.text = text
        label.textColor = UIColor(red:0.24, green:0.24, blue:0.24, alpha:1.0)
        label.font = UIFont(name: "AvenirNext-Bold", size: 14.0)
        label.frame = CGRectMake(14.0, 0.0, self.tableView.frame.width, 30.0)
        
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        view.addSubview(label)
        
        return view
    }
    
    private func getCompleteSource() -> [String]
    {
        var completeSource: [String] = []
        
        if let keywords = _searchController?.searchBar.text {
            completeSource.append(keywords)
        }
        
        completeSource += _presenter.suggestions
        
        return completeSource
    }
    
    // MARK: - UISEARCHRESULTSUPDATING
    
    internal func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        if let keywords = searchController.searchBar.text {
            if keywords.characters.count > 0 {
                _presenter.refreshAutocompletionSuggestions(forText: keywords)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UITABLEVIEWDATASOURCE
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var sectionsCounter = 0
        
        if let keywords = _searchController?.searchBar.text {
            if keywords.characters.count > 0 {
                sectionsCounter += 1
            }
        }
        
        if _presenter.suggestions.count > 0 {
            sectionsCounter += 1
        }
        
        return sectionsCounter
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 1
        case 1:
            return _presenter.suggestions.count
        case 2:
            return 0
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        let completeSource = self.getCompleteSource()
        
        let cell = tableView.dequeueReusableCellWithIdentifier(REUSE_CELL_IDENTIFIER,
                                                               forIndexPath: indexPath)
        
        let suggestion = completeSource[indexPath.row]
        cell.textLabel?.text = suggestion
        
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        switch (section) {
        case 0:
            let view = createSectionHeaderWithText("CONTINUE WITH...")
            return view
        case 1:
            let view = createSectionHeaderWithText("MAYBE YOU MEANT...")
            return view
        case 2:
            let label = UILabel()
            label.text = "Or you might have forgotten..."
            return label
        default:
            return UIView()
        }
    }
    
    // MARK: - UITABLEVIEWDELEGATE
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let completeSource = self.getCompleteSource()
        let selection = completeSource[indexPath.row]
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        _lastSelectedWord = selection
        self.performSegueWithIdentifier(WORD_SELECTION_TO_TRANSLATION_RECORDING_SEGUE,
                                        sender: self)
    }
    
}