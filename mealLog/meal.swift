//
//  meal.swift
//  mealLog
//
//  Created by Jianli He on 8/8/19.
//  Copyright © 2019 Jianli He. All rights reserved.
//

import UIKit
import os.log


class meal: NSObject,NSCoding {
    var name: String
    var photo: UIImage?
    var rating: Int
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARk: types
    struct PropertyKey {
        static let name="name"
        static let photo="photo"
        static let rating="rating"
    }
    
    init?(name:String,photo:UIImage?,rating:Int) {
        if name.isEmpty {return nil}
        if rating<0 || rating>5 {return nil}
        
        self.name=name
        self.photo=photo
        self.rating=rating
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder:NSCoder ) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
    }
    
    
}
