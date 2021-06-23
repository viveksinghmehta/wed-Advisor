//
//  PopularLocationsDashboardCell.swift
//  WedAdvisor
//
//  Created by Vivek Singh Mehta on 22/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SDWebImage

protocol PopularLocationDelegate: NSObject {
    func popularLocationSelected(index: Int)
}

class PopularLocationsDashboardCell: UITableViewCell {

    //MARK:- OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationTableView: ExpandingTableView!
    
    //MARK:- PROPERTIES
    weak var delegate: PopularLocationDelegate?
    var locations: [GetLocation]?
    
    //MARK:- IDENTIFIERS
    private let idetifier: String = "locationCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tabviewInit()
    }
    
    fileprivate func tabviewInit() {
        locationTableView.rowHeight = 160
        locationTableView.register(UINib(nibName: "PopularLocationCell", bundle: nil), forCellReuseIdentifier: idetifier)
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.reloadData()
    }
    
    func reloadTable() {
        locationTableView.reloadData()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PopularLocationsDashboardCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let locations = locations {
            return locations.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idetifier, for: indexPath) as? PopularLocationCell else { return UITableViewCell() }
        cell.cityLabel.text = Helper.optionalStringToString(value: locations?[indexPath.row].location?.city).uppercased()
        cell.numberOfVendorsLabel.text = Helper.optionalIntToString(value: locations?[indexPath.row].vendors) + " Vendors"
        cell.cityImageView.contentMode = .scaleAspectFill
        cell.cityImageView.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + Helper.optionalStringToString(value: locations?[indexPath.row].location?.logo)), placeholderImage: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.popularLocationSelected(index: indexPath.row)
    }
    
    
}
