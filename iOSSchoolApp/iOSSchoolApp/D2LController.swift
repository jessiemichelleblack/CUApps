//
//  D2LController.swift
//  iOSSchoolApp
//
//  Created by Jessie Albarian on 8/9/16.
//  Copyright © 2016 LittleBirdStudios. All rights reserved.
//

import UIKit

class D2LController: UIViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL (string: "https://learn.colorado.edu/");
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
        
        // Get rid of extra space above webview
        self.automaticallyAdjustsScrollViewInsets = false
        
        // Nav bar
        navigationController?.navigationBar.topItem?.title = "D2L"
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
