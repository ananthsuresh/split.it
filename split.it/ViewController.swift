//
//  ViewController.swift
//  split.it
//
//  Created by Ananth Suresh on 10/25/18.
//  Copyright © 2018 KAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func takePicture(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePickerController.sourceType = .camera
        self.present(imagePickerController, animated:true, completion: nil)
    }
    
    func imagePickercontroller(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

