//
//  StampViewController.swift
//  StampCollector
//
//  Created by Kari Newhouse on 5/19/17.
//  Copyright © 2017 Kari Code. All rights reserved.
//

import UIKit

class StampViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var stampImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var stamp : Stamp? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        if stamp != nil {
            stampImageView.image = UIImage(data: stamp!.image as! Data)
            titleTextField.text = stamp!.title
        }
    }

    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        stampImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let stamp = Stamp(context: context)
        stamp.title = titleTextField.text
        stamp.image = UIImagePNGRepresentation(stampImageView.image!)! as NSData
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}
