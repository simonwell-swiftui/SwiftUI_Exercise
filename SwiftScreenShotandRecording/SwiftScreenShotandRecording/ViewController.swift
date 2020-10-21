//
//  ViewController.swift
//  SwiftScreenShotandRecording
//
//  Created by simon.chang on 2020/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(didTakeScreenshot(notification:)), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        
    }
    
    @objc func didTakeScreenshot(notification:Notification) -> Void {
        print("Screen Shot Taken")
        let alert = UIAlertController(title: "Screen Shot", message: "Screen Shot Taken", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clickScreenRecordingCheck(_ sender: UIButton) {
        for screen in UIScreen.screens {
            if (screen.isCaptured) {
                let alert = UIAlertController(title: "Screen Recording Check", message: "Screen is recorded", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
     
    }
}

