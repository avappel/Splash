//
//  SelectPinDetailsViewController.swift
//  CSE438-MatthewYang
//
//  Created by Brandon Lum on 11/11/18.
//  Copyright © 2018 Matthew Yang. All rights reserved.
//

import UIKit
import MapKit

class SelectPinDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var picker: UIPickerView!//tag = 0
//    @IBOutlet weak var picker2: UIPickerView!//tag = 1
    // @IBOutlet weak var objectPicker: UIPickerView!
    @IBOutlet weak var segCon: UISegmentedControl!
    @IBOutlet weak var buildingTextField: UITextField!
    @IBOutlet weak var floorPicker: UIPickerView!
    @IBOutlet weak var selectPinLocationButton: UIButton!
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var descri: UILabel!
    @IBOutlet weak var descrip: UITextView!
    
    
    //defaults
    var object: String = "Bathroom" // bathroom or water fountain
    var floor: String = "5th Floor" // floor
    var building: String = "Building Name" // building name / location
    var detail: String = "Men's" //gender or temp
    var otherOption: Bool = false //shower/bottle
    var lat = 0
    var long = 0
    
    
    var location : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0,longitude: 0)
    
    var detailsArray = ["Men's", "Women's", "Neutral"]
    let genderArray = ["Men's", "Women's", "Neutral"]
    let tempArray = ["Cold", "Room Temp.", "Hot"]
    let floorArray = ["5th Floor", "4th Floor", "3rd Floor", "2nd Floor", "1st Floor", "0th Floor", "-1st Floor", "-2nd Floor", "-3rd Floor", "-4th FLoor"]//0th or ground?
    let placeholderText = "Description here"
    
    @IBAction func objectSelected(_ sender: Any) {
        
        if(segCon.selectedSegmentIndex == 0){
            detailsArray = genderArray
            optionButton.setTitle("Shower", for: .normal)
            object = "Bathroom"
        }
        else {
            detailsArray = tempArray
             optionButton.setTitle("Bottle Filler", for: .normal)
            object = "Water Fountain"
        }
        
        self.picker.reloadAllComponents() //reloads picker with data
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 0){
        return detailsArray.count;
        }
        else{
            return floorArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 0){
        return detailsArray[row];
        }
        else {
        return floorArray[row];
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 0){
            detail = detailsArray[row];//changes global varibales
        }
        if(pickerView.tag == 1) {
           floor = floorArray[row];
        }
    }
    
    //from stack overflow
    @IBAction func optionButtonCheckBox(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        otherOption = !otherOption;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    
    
    @IBAction func selectPinLocationButtonPressed(_ sender: Any) {
        // performSegue(withIdentifier: "SeguePinSelectionToMap", sender: self) //causes double segue
        //segue is performed in storyboard
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!){
        if segue.identifier == "SeguePinSelectionToMap"{
            print("pin to map button pressed; location = ")
            print(location)
            print(object)
            
            let vc = segue.destination as! MapViewController
            
//            let newAnnotation = MKPointAnnotation()
//            newAnnotation.coordinate = location
//            print(location)
//            newAnnotation.title = (object+" "+detail+" "+building)
//            print((object+" "+detail+" "+building))
//            newAnnotation.subtitle = (floor)
//            vc.addingAnnotation = newAnnotation
            
            vc.addingLoc = location
            vc.addingSub = floor
            vc.addingTitle = (object+" "+detail+" "+building)
            
         
            
            //vc.mapView.addAnnotation(newAnnotation)
            vc.isAddingPin = true
            
        }
    }
    
    @IBAction func getBuildingName(_ sender: Any) {
        building = buildingTextField.text!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        picker.dataSource = self
        
        floorPicker.delegate = self
        floorPicker.dataSource = self
        
        descrip.text = "Description Here"
        descrip.textColor = UIColor.lightGray
        descrip.returnKeyType = .done
        descrip.delegate = self
        
        buildingTextField.delegate = self
        descrip.text = "Building Name"
        descrip.textColor = UIColor.lightGray
        descrip.returnKeyType = .done
        
        optionButton.setImage(UIImage(named:"Checkmarkempty"), for: .normal)
        optionButton.setImage(UIImage(named:"Checkmark"), for: .selected)
        
        //objectPicker.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    //from https://www.youtube.com/watch?v=k6KBEspZxm8
    func textViewDidBeginEditing(_ textView: UITextView){
        if textView.text == "Description Here" {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
    if text == "\n" {
    textView.resignFirstResponder()
    }
    return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Description Here"
            textView.textColor = UIColor.lightGray
        }
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

