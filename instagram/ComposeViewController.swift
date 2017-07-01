//
//  ComposeViewController.swift
//  instagram
//
//  Created by Cameryn Boyd on 6/27/17.
//  Copyright © 2017 Cameryn Boyd. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //outlets
    //post image
    @IBOutlet weak var photoImageView: PFImageView!
    //take a photo label
    @IBOutlet weak var takePhotoButton: UIButton!
    //caption text field
    @IBOutlet weak var captionTextField: UITextField!
    
    let picker = UIImagePickerController()
    //actions
    
    
    
    
    //runs only when page is first opened
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        captionTextField.delegate = self
    }

    
    
    
    //share the post
    @IBAction func onShare(_ sender: Any) {
        print("about to call function11111")
        
      photoImageView.image = resize(image: photoImageView.image!, newSize: CGSize(width: 750, height: 750))
        print("about to call function")
        Post.postUserImage(image: photoImageView.image, withCaption: captionTextField.text) { (success: Bool, error: Error?) in
            if success {
                print("you posted")
//                self.performSegue(withIdentifier: "postSegue", sender: nil)
                self.tabBarController?.selectedIndex = 0
            } else {
                print("this is the sharing error: \(error?.localizedDescription)")
            }
        }
        
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    


    
    
    
    //take a photo action
    @IBAction func onTakePhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        //use the camera if it is available
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            print("camera is avaiable")
            vc.sourceType = UIImagePickerControllerSourceType.camera
            //otherwise use the photo library
        } else {
            print("Camera is not available so we will use photo library instead.")
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    //add a photo from the photo library action
    @IBAction func onAddPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        //use the library if can access
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            print("can access photos")
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //otherwise use the camera
        } else {
            print("Photo library is not available so we will use the camera instead.")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    


        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //saves the image once it is chosen
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
