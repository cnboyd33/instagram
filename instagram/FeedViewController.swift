//
//  FeedViewController.swift
//  instagram
//
//  Created by Cameryn Boyd on 6/27/17.
//  Copyright © 2017 Cameryn Boyd. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, PostCellDelegate {
    
    //variables
    var postArray: [PFObject] = []
    
    //outlets
    @IBOutlet weak var feedTableView: UITableView!


    //sends user to detail page
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let vc = segue.destination as! DetailViewController
            let cell = sender as! PostCell
            vc.caption = cell.captionLabel.text
            vc.username = cell.usernameLabel.text
            //vc.date = cell.creationDateLabel.text
            vc.profileImage = cell.profilePicImageView.file
            vc.postImage = cell.postImageView.file
            let indexPath = feedTableView.indexPath(for: cell)
            let post = postArray[(indexPath?.row)!]
            vc.post = post
        }
    }
    
    //log out action
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("onLogout"), object: nil)
            }
        })
    }
    
    
        
    
    //viewDidlLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        feedTableView.dataSource = self
        feedTableView.delegate = self

        // Do any additional setup after loading the view.
        let refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        //add refresh control to the table view
        feedTableView.insertSubview(refreshcontrol, at: 0)
        
    }
    
    //refresh function
    func refresh() {
        //construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.includeKey("media")
        query.includeKey("caption")
        query.includeKey("profile_pic")
        query.includeKey("createdAt")
        query.limit = 20
        //fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.postArray = posts
                self.feedTableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    //refresh control function
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    
    //tableView number of rows function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("hi")
        print(postArray)
        return postArray.count
    }
    
    //table # of cells per row function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        let posts = self.postArray[indexPath.row]
        cell.delegate = self
        print("here is the post object")
        cell.post = posts
        return cell
    }
    
    func didMoveToDetail(postCell: PostCell) {
        performSegue(withIdentifier: "detailSegue", sender: postCell)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
