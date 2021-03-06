//
//  PostCell.swift
//  instagram
//
//  Created by Cameryn Boyd on 6/28/17.
//  Copyright © 2017 Cameryn Boyd. All rights reserved.
//

import UIKit
import Parse
import ParseUI

@objc protocol PostCellDelegate {
    func didMoveToDetail(postCell: PostCell)
}

class PostCell: UITableViewCell {


    
   //outlets
    //post image
    @IBOutlet weak var postImageView: PFImageView!
    //caption
    @IBOutlet weak var captionLabel: UILabel!
    //creation date/time
    @IBOutlet weak var creationDateLabel: UILabel!
    //user profile picture
    @IBOutlet weak var profilePicImageView: PFImageView!
    //username
    @IBOutlet weak var usernameLabel: UILabel!
    
    //var postImage =
    var delegate: PostCellDelegate?
    //actions
    //go to profile function
 
    @IBAction func onUsernameButton(_ sender: Any) {
    }

    
    var post: PFObject! {
        didSet {
            self.profilePicImageView.file = post["profile_pic"] as? PFFile
            self.postImageView.file = post["media"] as? PFFile
            self.postImageView.loadInBackground()
            self.captionLabel.text = (post["caption"] as! String)
            self.creationDateLabel.text = post["_created_at"] as? String
            if let user = post["author"] as? PFUser {
                self.usernameLabel.text = user.username
            } else {
                self.usernameLabel.text = ":^)"
            }
            
            if let creationDateLabel = post["creationTime"] {
                let postDateFormatter: DateFormatter = {
                    let f = DateFormatter()
                    f.dateFormat = "MMM d, yyyy"
                    return f
                }()
                self.creationDateLabel.text = postDateFormatter.string(from: Date(timeIntervalSinceReferenceDate: creationDateLabel as! TimeInterval))
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Make profile pic circular
        profilePicImageView.layer.borderWidth = 1
        profilePicImageView.layer.masksToBounds = false
        profilePicImageView.layer.borderColor = UIColor.lightGray.cgColor
        profilePicImageView.layer.cornerRadius = profilePicImageView.frame.height/2
        profilePicImageView.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSendToDetail(_ sender: Any) {
        print("about to go to detail")
        print(delegate)
        delegate!.didMoveToDetail(postCell: self)
    }
}
