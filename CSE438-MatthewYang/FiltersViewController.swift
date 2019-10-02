//
//  FiltersViewController.swift
//  CSE438-MatthewYang
//
//  Created by labuser on 11/13/18.
//  Copyright © 2018 Matthew Yang. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {
    let themeColor = UIColor.white/* UIColor.init(red: 0.35, green: 0.682, blue: 0.996078, alpha: 1)*/
    
    @IBOutlet weak var filtersText: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    
    static var maleSelected: Bool = true
    static var femaleSelected: Bool = true
    static var neutralSelected: Bool = true
    
    override func viewDidLoad() {
    maleButton.layer.cornerRadius = 0.5 * maleButton.bounds.size.width
        if FiltersViewController.maleSelected {
            maleButton.backgroundColor = themeColor
        }
    femaleButton.layer.cornerRadius = 0.5 * maleButton.bounds.size.width
        if FiltersViewController.femaleSelected{
            femaleButton.backgroundColor = themeColor
        }
    neutralButton.layer.cornerRadius = 0.5 * maleButton.bounds.size.width
        if FiltersViewController.neutralSelected{
            neutralButton.backgroundColor = themeColor
        }
        view.addBackground()
    }
    @IBAction func maleButtonPress(_ sender: Any) {
        FiltersViewController.maleSelected = !FiltersViewController.maleSelected
        
        if (FiltersViewController.maleSelected){
            maleButton.backgroundColor = themeColor
        }
        else{
            maleButton.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func femaleButtonPress(_ sender: Any) {
        FiltersViewController.femaleSelected = !FiltersViewController.femaleSelected
        if (FiltersViewController.femaleSelected){
            femaleButton.backgroundColor = themeColor
        }
        else{
            femaleButton.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func neutralButtonPress(_ sender: Any) {
        FiltersViewController.neutralSelected = !FiltersViewController.neutralSelected
        if (FiltersViewController.neutralSelected){
            neutralButton.backgroundColor = themeColor
        }
        else{
            neutralButton.backgroundColor = UIColor.clear
        }
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
