//
//  ViewController.swift
//  SystemViewController
//
//  Created by Divya Arora on 20/11/24.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func ShareButtonType(_ sender: UIButton) {
        guard let image = ImageView.image else { return }
        
        let activityController = UIActivityViewController (activityItems: [image], applicationActivities: nil)
        
//        activityController.popoverPresentationController?.sourceView = sender
        
        present(activityController, animated: true, completion: nil)
    }
    
    
    @IBAction func SafariButton(_ sender: UIButton) {
        
        if let url = URL(string: "https://www.apple.com/in/") {
            let safariController = SFSafariViewController(url: url)
            
            present(safariController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func CameraButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler:  { (action) in print("User Has Choosen Camera")
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
                
            })
            
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in print("User Has Choosen Photo Library")
                
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
                
            })
            alertController.addAction(photoLibraryAction)
        }
        
        present(alertController, animated: true, completion: nil)
            
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        ImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
        
    
    @IBAction func EmailButton(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            print("not able to send email")
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.delegate = self
        
        mailComposer.setSubject("Dummy Email")
        mailComposer.setToRecipients(["divyaarorag@gmail.com"])
        mailComposer.setMessageBody("Hello, this is a test email", isHTML: false)
        present(mailComposer, animated: true, completion: nil)
        
    }
    
}
    
    
    



