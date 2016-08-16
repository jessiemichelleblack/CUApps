//
//  GetInfoViewController.swift
//  iOSSchoolApp
//
//  Created by Jessie Albarian on 8/13/16.
//  Copyright © 2016 LittleBirdStudios. All rights reserved.
//

import UIKit

class GetInfoViewController: UIViewController, UIPopoverPresentationControllerDelegate {


    @IBOutlet var infoTitle: UILabel!
    var infoPic : UIImageView?
    var hours : String = ""
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let getInfoViewController =  GetInfoViewController()
//        getInfoViewController.modalPresentationStyle = .Popover
//        getInfoViewController.preferredContentSize = CGSizeMake(50, 100)
        
        infoTitle.center = CGPointMake(160, 284)
        infoTitle.textAlignment = NSTextAlignment.Center
        infoTitle.text = hours
        
        infoPic = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        infoPic!.contentMode = .ScaleAspectFit
        infoPic!.image = UIImage(named: "default")
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
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
