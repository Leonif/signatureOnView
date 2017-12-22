//
//  ViewController.swift
//  TestSignature2
//
//  Created by LEONID NIFANTIJEV on 12/22/17.
//  Copyright © 2017 LEONID NIFANTIJEV. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var signatureView: SignutureView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
       
    }

   
    @IBAction func press(_ sender: UIButton) {
        
        imageView.image = signatureView.image
        
    }
    

}

