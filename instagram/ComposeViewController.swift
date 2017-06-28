//
//  ComposeViewController.swift
//  instagram
//
//  Created by Cameryn Boyd on 6/27/17.
//  Copyright © 2017 Cameryn Boyd. All rights reserved.
//

import UIKit
import Parse

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var takePhotoButton: UIButton!
    
    @IBAction func onTakePhoto(_ sender: Any) {
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
    
    
    @IBAction func onAddPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            print("can access photos")
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        } else {
            print("Photo library is not available so we will use the camera instead.")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //get the image captured by the uiimagepickercontroller
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //do something with the images (based on your use case)
        
        //dimsiss uiimagepickercontroller to go back to your original view controller
        dismiss(animated: true, completion: nil)
        
        photoImageView.image = editedImage
        
        if photoImageView.image != nil {
            takePhotoButton.titleLabel?.text = ""
        }
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
