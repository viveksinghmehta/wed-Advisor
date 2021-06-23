//
//  VendorOptionSelectionCell.swift
//  WedAdvisor
//

//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class VendorOptionSelectionCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var viewAbout: UIView!
    @IBOutlet weak var tblAbout: UITableView!
    @IBOutlet weak var heightTable: NSLayoutConstraint!
    @IBOutlet weak var heightViewTable: NSLayoutConstraint!
    var desc : String?
    var hotelName : String?
    var arrAmnities : [amenitiesData]?
    var itemlist: [HomeItemList]?
    var selectDropTable : (() -> ())?
    var value : Bool?
    var controller: UITableViewCell?

    static let sharedInstance = VendorOptionSelectionCell()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerNibs()
        tblAbout.dataSource = self
        tblAbout.delegate = self
       // connfigCollectionHeight()
    }
//MARK:- Register Nib
    func registerNibs(){
        let aboutNib = UINib(nibName: "AboutCell" , bundle: nil)
        self.tblAbout.register(aboutNib, forCellReuseIdentifier: "AboutCell")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func connfigCollectionHeight(){
            let numberOfLines = arrAmnities?.count ?? 0
            heightTable.constant = CGFloat(36*numberOfLines+200)
            tblAbout.reloadData()
    }
    
    func connfigCollectionHeightwo(){
            let numberOfLines = arrAmnities?.count ?? 0
            heightTable.constant = CGFloat(40*numberOfLines)
            print(heightTable.constant)
            tblAbout.reloadData()
    }
    //MARK:- Table Delegate & Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
     }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAbout.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutCell
        cell.lblHotel.text = hotelName
        cell.lblDesc.text = desc
         if self.arrAmnities != nil{
        cell.arrAmnities = self.arrAmnities!
        cell.connfigCollectionHeight()
        }

        cell.itemlist = itemlist
        cell.collectionSimmilarVendor.reloadData()
        cell.collectionAmenities.reloadData()
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return tblAbout.estimatedRowHeight
    }
    
}
