//
//  AddViewController.swift
//  ScavengerHunt
//
//  Created by Nguyet Duong on 8/8/15.
//  Copyright (c) 2015 Nguyet Duong. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var newItem: ScavengerHuntItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // IBAction is put so that the storyboard knows about it and can understand/implement it
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil) // we use nil because it isn't necessary at the moment
    }
    
    // this is where we take information from text field and store it
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // need to ask if this is the correct segue
        if segue.identifier == "DoneItem" {
            if let textFieldValue = textField.text {
                if !textFieldValue.isEmpty {
                    newItem = ScavengerHuntItem(name: textFieldValue)
                }
                
            }
        }
    }

}

