//
//  ViewController.swift
//  YDPProgressBar
//
//  Created by José Miguel Herrero on 02/11/2019.
//  Copyright (c) 2019 José Miguel Herrero. All rights reserved.
//

import UIKit
import YDPProgressBar

class ViewController: UIViewController {

    @IBOutlet weak var progressBar: YDPProgressBar!
    
    @IBAction func buttonMinus(_ sender: Any) {
        let progress = progressBar.progress / progressBar.frame.width
        self.progressBar.progress(progress - 0.1, animated: true)
    }
    
    @IBAction func buttonPlus(_ sender: Any) {
        let progress = progressBar.progress / progressBar.frame.width
        self.progressBar.progress(progress + 0.1, animated: true)
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

