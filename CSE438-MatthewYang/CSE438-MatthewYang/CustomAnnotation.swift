//
//  CustomAnnotation.swift
//  CSE438-MatthewYang
//
//  Created by Brandon Lum on 11/12/18.
//  Copyright © 2018 Matthew Yang. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var title : String?
    var coordinate : CLLocationCoordinate2D
    var subTit : String?
    
    init(title:String,coordinate : CLLocationCoordinate2D,subtitle:String){
        self.title = title;
        self.coordinate = coordinate;
        self.subTit = subtitle;
        
    }
    
}
