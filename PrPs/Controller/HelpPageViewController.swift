//
//  HelpPageViewController.swift
//  PrPs
//
//  Created by fpmi on 31.05.2018.
//  Copyright © 2018 Ekaterina Zhukova. All rights reserved.
//

import UIKit
import MapKit


class HelpPageViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var kateMailLink: UITextView!
    @IBOutlet weak var janeMaillink: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    func addLink(){
        let attributedString = NSMutableAttributedString(string: "kate.zhukova.98@gmail.com")
        attributedString.addAttribute(.link, value: "https://mail.google.com/mail/?view=cm&fs=1&to=kate.zhukova.98@gmail.com", range: NSRange(location: 0, length: 25))
        let attributedString_ = NSMutableAttributedString(string: "janeketko@gmail.com")
        attributedString_.addAttribute(.link, value: "https://mail.google.com/mail/?view=cm&fs=1&to=janeketko@gmail.com", range: NSRange(location: 0, length: 19))
        
        kateMailLink.attributedText = attributedString
        janeMaillink.attributedText=attributedString_
        
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addLink()
       
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
