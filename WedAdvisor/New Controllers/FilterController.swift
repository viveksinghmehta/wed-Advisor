//
//  FilterController.swift
//  WedAdvisor
//
//  Created by WishACloud on 28/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import BetterSegmentedControl

protocol FilterDelegate: NSObject {
    func filterSelected(locationID: Int?, vendorID: Int?, rating: String?, amenties: [Int])
}

final class FilterController: UIViewController {

    enum FilterOptions {
        case vendor
        case location
        case rating
        case advance
    }

    @IBOutlet weak var segmentController: BetterSegmentedControl!
    @IBOutlet weak var filterTableView: UITableView!
    
    private let identifier: String = "filterCell"
    private var isSingleSelection = true
    private var options: FilterOptions = .vendor
    
    var locations = [VenueLocation]()
    var vendors = [VendorTypeData]()
    var rating: [String] = ["4", "3", "2", "1"]
    var amneties = [Amenity]()
    var locationID: Int?
    var vendorID: Int?
    var selectedRating: String?
    
    weak var delegate: FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segment()
        tableViewInit()
    }
    
    fileprivate func segment() {
        segmentController.segments = LabelSegment.segments(withTitles: ["Vendor Type", "Location", "Rating", "Advance Option"], normalBackgroundColor: .white, normalFont: UIFont(name: "ProductSans-Regular", size: 14), normalTextColor: WedAdviserColor.themeOrangeColor(), selectedBackgroundColor: WedAdviserColor.themeOrangeColor(), selectedFont: UIFont(name: "ProductSans-Medium", size: 14), selectedTextColor: .white)
    }
    
    
    fileprivate func tableViewInit() {
        filterTableView.rowHeight = 44
        filterTableView.register(UINib(nibName: "FilterCell", bundle: nil), forCellReuseIdentifier: identifier)
        filterTableView.delegate = self
        filterTableView.dataSource = self
    }
    
    @IBAction func segmentChangedValue(_ sender: BetterSegmentedControl) {
        if sender.index == 0 { // Vendors
            options = .vendor
            isSingleSelection = true
        } else if sender.index == 1 { // location
            options = .location
            isSingleSelection = true
        } else if sender.index == 2 { // rating
            options = .rating
            isSingleSelection = true
        } else { // advance options
            options = .advance
            isSingleSelection = false
        }
        filterTableView.reloadData()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyAction(_ sender: UIButton) {
        let temp = amneties.map( { Helper.optionalIntToInt(value: $0.id) } )
        delegate?.filterSelected(locationID: locationID, vendorID: vendorID, rating: selectedRating, amenties: temp)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension FilterController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch options {
        case .vendor:
            return vendors.count
        case .location:
            return locations.count
        case .rating:
            return rating.count
        case .advance:
            return amneties.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FilterCell else { return UITableViewCell() }
        switch options {
        case .vendor:
            cell.titleLabel.text = Helper.optionalStringToString(value:  vendors[indexPath.row].name)
            if vendors[indexPath.row].id == vendorID {
                cell.checked = true
            } else {
                cell.checked = false
            }
        case .location:
            cell.titleLabel.text = Helper.optionalStringToString(value: locations[indexPath.row].city).capitalizingFirstLetter()
            if locations[indexPath.row].id == locationID {
                cell.checked = true
            } else {
                cell.checked = false
            }
        case .rating:
            cell.titleLabel.text = rating[indexPath.row] + " ⭐️ & above"
            if rating[indexPath.row] == selectedRating {
                cell.checked = true
            } else {
                cell.checked = false
            }
        case .advance:
            cell.titleLabel.text = Helper.optionalStringToString(value: amneties[indexPath.row].amenitiesOption)
            cell.checked = amneties[indexPath.row].isSelected
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FilterCell else { return }
        switch options {
        case .vendor:
            if vendorID != nil {
                let index = vendors.firstIndex(where: { $0.id == vendorID })
                guard let previousCell = tableView.cellForRow(at: IndexPath(row: index ?? 0, section: 0)) as? FilterCell else { return }
                previousCell.checked = false
            }
            cell.checked = true
            vendorID = vendors[indexPath.row].id ?? 0
        case .location:
            if locationID != nil {
                let index = locations.firstIndex(where: { $0.id == locationID })
                guard let previousCell = tableView.cellForRow(at: IndexPath(row: index ?? 0, section: 0)) as? FilterCell else { return }
                previousCell.checked = false
            }
            cell.checked = true
            locationID = locations[indexPath.row].id ?? 0
        case .rating:
            if selectedRating != nil {
                let index = rating.firstIndex(where: { $0 == selectedRating })
                guard let previousCell = tableView.cellForRow(at: IndexPath(row: index ?? 0, section: 0)) as? FilterCell else { return }
                previousCell.checked = false
            }
            cell.checked = true
            selectedRating = rating[indexPath.row]
        case .advance:
            cell.checked = !amneties[indexPath.row].isSelected
            amneties[indexPath.row].isSelected = !amneties[indexPath.row].isSelected
        }
    }
    
    
}
