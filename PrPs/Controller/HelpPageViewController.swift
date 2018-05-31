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
    let hereWeAre:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 53.891900, longitude: 27.566999)
    func addLink(){
        let attributedString = NSMutableAttributedString(string: "kate.zhukova.98@gmail.com")
        attributedString.addAttribute(.link, value: "https://mail.google.com/mail/?view=cm&fs=1&to=kate.zhukova.98@gmail.com", range: NSRange(location: 0, length: 25))
        let attributedString_ = NSMutableAttributedString(string: "janeketko@gmail.com")
        attributedString_.addAttribute(.link, value: "https://mail.google.com/mail/?view=cm&fs=1&to=janeketko@gmail.com", range: NSRange(location: 0, length: 19))
        
        kateMailLink.attributedText = attributedString
        janeMaillink.attributedText=attributedString_
        
    }
    func addPointOnMap(point:CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = point
        mapView.addAnnotation(annotation)
        
    }
    func setRegion(center:CLLocationCoordinate2D){
        let center = center
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        mapView.setRegion(region, animated: true)
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL, options: [:])
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLink()
        addPointOnMap(point: hereWeAre)
        setRegion(center: hereWeAre)
       
       
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
