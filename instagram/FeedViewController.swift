//
//  FeedViewController.swift
//  instagram
//
//  Created by Cameryn Boyd on 6/27/17.
//  Copyright © 2017 Cameryn Boyd. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //variables
    var postArray: [PFObject] = []
    
    //outlets
    @IBOutlet weak var feedTableView: UITableView!

    //log out action
    @IBAction func onLogOut(_ sender: Any) {
            PFUser.logOutInBackground { (error: Error?) in
                PFUser.current() == nil
            }
        }
    
    //camera function
    @IBAction func onCamera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            print("camera is avaiable")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            print("Camera is not available so we will use photo library instead.")
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    //saves the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //get the image captured by the uiimagepickercontroller
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //do something with the images (based on your use case)
        
        //dimsiss uiimagepickercontroller to go back to your original view controller
        dismiss(animated: true, completion: nil)
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
        print("here is the post object")
        cell.post = posts
        return cell
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
