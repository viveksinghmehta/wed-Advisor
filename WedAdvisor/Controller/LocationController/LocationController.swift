//
//  LocationController.swift
//  WedAdvisor
//
//  Created by Vishal Pandey on 18/01/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import DefaultsKit



protocol LocationDelegate: NSObject {
   func locationSelected(city: String)
}

class LocationController: UIViewController {
    
    @IBOutlet weak var btnSelectCity: UIButton!
    @IBOutlet weak var locationTbl: UITableView!
    @IBOutlet weak var selectCityLbl: UILabel!
    @IBOutlet weak var txtcitySearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    weak var delegate: LocationDelegate?
    var arrPopularLoc : [HomeLocation]?
    var arrPopularLocNew : [HomeLocation]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backBtn(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectCityBtnTapped(sender: UIButton){
        
    }
    @IBAction func currentLocationBtnTapped(sender: UIButton){
        
    }
    
    @IBAction func searchBtnTapped(sender: UIButton){
        
    }
    
    
}

extension LocationController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPopularLoc?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationTbl.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        let dict = arrPopularLoc?[indexPath.row]
        cell.cityLbl.text = Helper.optionalStringToString(value: dict?.city).capitalizingFirstLetter()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "VendorFilterVC") as? VendorFilterVC
        //        let a = arrPopularLocNew?[indexPath.row]
        //        vc?.vendorType = a?.id
        //        vc?.checkforLocation =  true
        //        self.navigationController?.pushViewController(vc!, animated: true)
        if let location = arrPopularLoc?[indexPath.row] {
            Defaults().set(location, for: .location)
        }
        delegate?.locationSelected(city: Helper.optionalStringToString(value: arrPopularLoc?[indexPath.row].city))
        dismiss(animated: true, completion: nil)
    }
    
}
