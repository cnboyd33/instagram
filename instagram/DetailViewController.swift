//
//  DetailViewController.swift
//  instagram
//
//  Created by Cameryn Boyd on 6/29/17.
//  Copyright © 2017 Cameryn Boyd. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {
    
    var post: PFObject!
    var caption: String!
    var username: String!
    var date: String!
    var profileImage: PFFile!
    var postImage: PFFile!

    //post image
    @IBOutlet weak var photoImageView: PFImageView!
    //profile pic
    @IBOutlet weak var profileImageView: PFImageView!
    //caption label
    @IBOutlet weak var captionLabel: UILabel!
    //creation date label
    @IBOutlet weak var creationDateLabel: UILabel!
    //usernameLabel
    @IBOutlet weak var usernameLabel: UILabel!
    //goes to profile page
    @IBAction func onUsername(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

            self.profileImageView.file = profileImage
            self.photoImageView.file = postImage
            self.photoImageView.loadInBackground()
            self.profileImageView.loadInBackground()
            self.captionLabel.text = caption
            if let user = username {
                self.usernameLabel.text = username
            } else {
                self.usernameLabel.text = ":^)"
            
            }
            print(post)
            print(post.createdAt)
        
            if let date = post.createdAt {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .short
                let dateString = dateFormatter.string(from: date)
                print(dateString) // Prints: Jun 28, 2017, 2:08 PM
            
            creationDateLabel.text = dateString
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


        // Do any additional setup after loading the view.




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

