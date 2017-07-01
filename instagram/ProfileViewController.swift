//
//  ProfileViewController.swift
//  instagram
//
//  Created by Cameryn Boyd on 6/28/17.
//  Copyright © 2017 Cameryn Boyd. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var profilePost: [PFObject] = []
    
    //profile pic image
    @IBOutlet weak var profileImageView: UIImageView!
    //username
    @IBOutlet weak var usernameLabel: UILabel!
    //biography
    @IBOutlet weak var bioLabel: UILabel!
    //collection view
    @IBOutlet weak var profileCollectionView: UICollectionView!
        
   
    
    
    //goes to settings page
    @IBAction func onSettings(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profilePost.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCell
        
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
