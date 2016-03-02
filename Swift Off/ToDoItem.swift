//
//  ToDoItem.swift
//  Swift Off
//
//  Created by Ashkan Kashani on 2/19/16.
//  Copyright © 2016 Primer. All rights reserved.
//

import Foundation
import Firebase

class ToDoItem: NSObject {
    var key: String
    var isComplete: Bool
    var createdAt: NSDate
    var text: String
    let fireBaseRef: Firebase = Firebase(url: FIREBASE_BASE_URL + "/todos")
    
    init(text: String) {
        self.text = text
        self.key = ""
        self.createdAt = NSDate()
        self.isComplete = false
    }
    
    init(text: String, key: String, timeSince1970: NSTimeInterval, isComplete: Bool) {
        self.text = text
        self.key = key
        self.createdAt = NSDate.init(timeIntervalSince1970: timeSince1970)
        self.isComplete = isComplete
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "text": self.text,
            "createdAt": self.createdAt.timeIntervalSince1970,
            "isComplete": self.isComplete
        ]
    }
    
    func save() {
        let toDoRef: Firebase
        if self.key == "" {
            toDoRef = self.fireBaseRef.childByAutoId()
        } else {
            toDoRef = self.fireBaseRef.childByAppendingPath(self.key)
        }
        toDoRef.setValue(self.toAnyObject())
    }
}