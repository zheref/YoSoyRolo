//
//  SimplePopup.swift
//  YoSoyRolo
//
//  Created by Sergio Daniel Leztark on 5/30/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class SimplePopup {
    
    /**
     *
     */
    internal static func alert(message: String, from vm: UIViewController) {
        let alert: UIAlertController = UIAlertController(title: "Alert", message: message,
                                                         preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
            handler: { (action: UIAlertAction) -> Void in
                // Do nothing. Just dismiss
        }))
        
        vm.presentViewController(alert, animated: true, completion: nil)
    }
    
    internal static func alert(message: String, withTitle title: String, from vm: UIViewController) {
        let alert: UIAlertController = UIAlertController(title: title, message: message,
                                                         preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,
            handler: { (action: UIAlertAction) -> Void in
                // Do nothing. Just dismiss
        }))
        
        vm.presentViewController(alert, animated: true, completion: nil)
    }
    
    internal static func confirm(message: String, withTitle title: String, from vm: UIViewController, ifYes doThis: () -> Void) {
        let confirmation: UIAlertController = UIAlertController(title: title, message: message,
                                                                preferredStyle: UIAlertControllerStyle.Alert)
        
        confirmation.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default,
            handler: { (action: UIAlertAction) -> Void in
                doThis();
            }
            ))
        
        confirmation.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel,
            handler: { (action: UIAlertAction) -> Void in
                // Do nothing. Just dismiss
            }
            ))
    }
    
}