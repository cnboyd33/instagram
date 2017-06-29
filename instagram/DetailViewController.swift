//
//  DetailViewController.swift
//  instagram
//
//  Created by Cameryn Boyd on 6/29/17.
//  Copyright © 2017 Cameryn Boyd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //post image
    @IBOutlet weak var photoImageView: UIImageView!
    //profile pic
    @IBOutlet weak var profileImageView: UIImageView!
    //caption label
    @IBOutlet weak var captionLabel: UILabel!
    //creation date label
    @IBOutlet weak var creationDateLabel: UILabel!
    //goes to profile page
    @IBAction func onUsername(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
