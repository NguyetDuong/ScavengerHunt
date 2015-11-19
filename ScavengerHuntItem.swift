//
//  ScavengerHuntItem.swift
//  ScavengerHunt
//
//  Created by Nguyet Duong on 8/8/15.
//  Copyright (c) 2015 Nguyet Duong. All rights reserved.
//

import UIKit

class ScavengerHuntItem: NSObject, NSCoding {
    let nameKey = "nameKey"
    let photoKey = "photoKey"
    
    let name: String
    var photo: UIImage?
    var isComplete: Bool {
        get {
            return photo != nil
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)

        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
    }
}