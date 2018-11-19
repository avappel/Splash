//
//  FiltersViewController.swift
//  CSE438-MatthewYang
//
//  Created by labuser on 11/13/18.
//  Copyright © 2018 Matthew Yang. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {
    
    @IBOutlet weak var filtersText: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    
    @IBOutlet weak var overallLabel: UILabel!
    @IBOutlet weak var cleanlinessLabel: UILabel!
    @IBOutlet weak var crowdednessLabel: UILabel!
    @IBOutlet weak var overallSlider: UISlider!
    @IBOutlet weak var cleanlinessSlider: UISlider!
    @IBOutlet weak var crowdednessSlider: UISlider!
    @IBOutlet weak var val1: UILabel!
    @IBOutlet weak var val2: UILabel!
    @IBOutlet weak var val3: UILabel!
    
    var overallFilter = 1.0
    var cleanlinessFilter = 1.0
    var crowdednessFilter = 1.0
    
    var genderSelection = 0;
    var maleSelected: Bool = false
    
    override func viewDidLoad() {
    maleButton.layer.cornerRadius = 0.5 * maleButton.bounds.size.width
    maleButton.backgroundColor = UIColor.lightGray
    femaleButton.layer.cornerRadius = 0.5 * maleButton.bounds.size.width
    femaleButton.backgroundColor = UIColor.lightGray
    neutralButton.layer.cornerRadius = 0.5 * maleButton.bounds.size.width
    neutralButton.backgroundColor = UIColor.lightGray
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background1.png")!)
        val1.text = String(overallFilter)
        val2.text = String(cleanlinessFilter)
        val3.text = String(crowdednessFilter)
        view.addBackground()
    }
    @IBAction func maleButtonPress(_ sender: Any) {
        if (genderSelection==1){
            genderSelection = 0
        }
        else{
            genderSelection = 1
        }
        if (genderSelection==1){
             maleButton.backgroundColor = UIColor.green
             femaleButton.backgroundColor = UIColor.gray
             neutralButton.backgroundColor = UIColor.gray
        }
        else{
            maleButton.backgroundColor = UIColor.gray
        }
        print(genderSelection)
    }
    
    @IBAction func femaleButtonPress(_ sender: Any) {
        if (genderSelection==2){
            genderSelection = 0
        }
        else{
            genderSelection = 2
        }
        if (genderSelection==2){
            femaleButton.backgroundColor = UIColor.green
            maleButton.backgroundColor = UIColor.gray
            neutralButton.backgroundColor = UIColor.gray
        }
        else{
            femaleButton.backgroundColor = UIColor.gray
        }
        print(genderSelection)
    }
    
    @IBAction func neutralButtonPress(_ sender: Any) {
        if (genderSelection==3){
            genderSelection = 0
        }
        else{
            genderSelection = 3
        }
        if (genderSelection==3){
            neutralButton.backgroundColor = UIColor.green
            femaleButton.backgroundColor = UIColor.gray
            maleButton.backgroundColor = UIColor.gray
        }
        else{
            neutralButton.backgroundColor = UIColor.gray
        }
        print(genderSelection)
    }
    
    @IBAction func slider1(_ sender: UISlider) {
        overallFilter = Double(5*Int(sender.value*10))/10.0
        val1.text = String(overallFilter)
    }
    
    @IBAction func slider2(_ sender: UISlider) {
        cleanlinessFilter = Double(5*Int(sender.value*10))/10.0
        val2.text = String(cleanlinessFilter)
    }
    
    @IBAction func silder3(_ sender: UISlider) {
        crowdednessFilter = Double(5*Int(sender.value*10))/10.0
        val3.text = String(crowdednessFilter)
    }
    
    
    
    }





//from https://stackoverflow.com/questions/27153181/how-do-you-make-a-background-image-scale-to-screen-size-in-swift/41581146#41581146
extension UIView {
    func addBackground(imageName: String = "Background1.png", contentMode: UIViewContentMode = .scaleAspectFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundImageView)
        sendSubview(toBack: backgroundImageView)
        
        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}

