//
//  Post.swift
//  instagram
//
//  Created by Cameryn Boyd on 6/27/17.
//  Copyright © 2017 Cameryn Boyd. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    
    let creationTime: TimeInterval?
    let media: PFFile?
    let author: String?
    let caption: String?
    let likesCount: Int?
    let commentsCount: Int?
    
    init(pfObject: PFObject) {
        creationTime = pfObject["creationTime"] as? TimeInterval
        media = pfObject["media"] as? PFFile
        author = pfObject["author"] as? String
        caption = pfObject["caption"] as? String
        likesCount = pfObject["likesCount"] as? Int
        commentsCount = pfObject["commentsCount"] as? Int
    }
    
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        //create parse object PFObject
        let post = PFObject(className: "Post")
        //add relevant fields to the object
        post["media"] = getPFFileFromImage(image: image) // PFFile column type
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption ?? ""
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
        print("post was saved")
        

    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}
