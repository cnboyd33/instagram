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

class PostCell: UITableViewCell {


    
   //outlets
    //post image
    @IBOutlet weak var postImageView: PFImageView!
    //profile image
    @IBOutlet weak var profileImageView: PFImageView!
    //caption
    @IBOutlet weak var captionLabel: UILabel!
    //creation date/time
    @IBOutlet weak var creationDateLabel: UILabel!
    //user profile picture
    @IBOutlet weak var profilePicImageView: PFImageView!
    //username
    @IBOutlet weak var usernameLabel: UILabel!
    
    //var postImage =
    
    //actions
    //go to profile function
    @IBAction func onUsernameButton(_ sender: Any) {
    }

    
    var post: PFObject! {
        didSet {
            self.postImageView.file = post["media"] as? PFFile
            self.postImageView.loadInBackground()
            self.captionLabel.text = post["caption"] as! String
            self.creationDateLabel.text = post["_created_at"] as? String
            if let user = post["author"] as? PFUser {
                self.usernameLabel.text = user.username
            } else {
                self.usernameLabel.text = ":^)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
