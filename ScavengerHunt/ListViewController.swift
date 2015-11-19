//
//  ListViewController.swift
//  ScavengerHunt
//
//  Created by Nguyet Duong on 8/8/15.
//  Copyright (c) 2015 Nguyet Duong. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // creating an array
//    var itemsList = [ScavengerHuntItem(name: "Leslie"), ScavengerHuntItem(name: "Ilona"), ScavengerHuntItem(name: "Ming"),
//        ScavengerHuntItem(name: "Mimi"), ScavengerHuntItem(name: "Apple")]

    let itemsManager = ItemsManager()
    
    // implementation of segue to do shit correct
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            let addItemController = segue.sourceViewController as! AddViewController
            if let newItem = addItemController.newItem {
                itemsManager.items += [newItem]
                itemsManager.save()
                // it is minus one because lelele we just added it in the line above
                let indexPath = NSIndexPath(forRow: itemsManager.items.count - 1, inSection: 0)
                // we stuck it into an array bc it's expect multiple
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagePicker = UIImagePickerController()
        // if we have a camera available
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow() {
            let selectedItem = itemsManager.items[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedItem.photo = photo
            itemsManager.save()
            dismissViewControllerAnimated(true, completion: { () -> Void in
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            })
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsManager.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // we're forcing it to be returned as a UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath) as! UITableViewCell
        
        // optional -- so now we need to unwrap it
        let item = itemsManager.items[indexPath.row]
        cell.textLabel?.text = item.name
        
        if item.isComplete {
            cell.accessoryType = .Checkmark
            cell.imageView?.image = item.photo
        } else {
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        
        return cell
        
    }
    
}