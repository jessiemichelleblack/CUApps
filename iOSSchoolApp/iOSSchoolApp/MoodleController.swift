//
//  MoodleController.swift
//  iOSSchoolApp
//
//  Created by Jessie Albarian on 8/9/16.
//  Copyright © 2016 LittleBirdStudios. All rights reserved.
//

import UIKit

class MoodleController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL (string: "https://moodle.cs.colorado.edu/");
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
        
        navigationController?.navigationBar.topItem?.title = "Moodle"
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
