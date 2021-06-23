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
    func popularLocationSelected(selected: Int, indexPath: IndexPath)
}

class PopularLocationsDashboardCell: UITableViewCell {

    //MARK:- OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    //MARK:- PROPERTIES
    weak var delegate: PopularLocationDelegate?
    var locations: [GetLocation]?
    var index: IndexPath = IndexPath(row: 0, section: 0)
    
    //MARK:- IDENTIFIERS
    private let idetifier: String = "locationCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tabviewInit()
    }
    
    fileprivate func tabviewInit() {
        locationCollectionView.register(UINib(nibName: "PopularLocationCell", bundle: nil), forCellWithReuseIdentifier: idetifier)
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        locationCollectionView.reloadData()
    }
    
    func reloadTable() {
        locationCollectionView.reloadData()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension PopularLocationsDashboardCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let locations = locations {
            return locations.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idetifier, for: indexPath) as? PopularLocationCell else { return UICollectionViewCell() }
        cell.cityName.text = Helper.optionalStringToString(value: locations?[indexPath.row].location?.city).uppercased()
        cell.vendorNo.text = Helper.optionalIntToString(value: locations?[indexPath.row].vendors) + " Vendors"
        cell.cityImageView.contentMode = .scaleAspectFill
        cell.cityImageView.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + Helper.optionalStringToString(value: locations?[indexPath.row].location?.logo)), placeholderImage: nil)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3 , height: collectionView.bounds.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.popularLocationSelected(selected: indexPath.row, indexPath: index)
    }
    
    
}
