//
//  PopularCategoriesDashboardCell.swift
//  WedAdvisor
//
//  Created by Vivek Singh Mehta on 22/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class PopularCategoriesDashboardCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var popularCategories: [HomeVendorType]?
    
    private let identifier: String = "categoryCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryInit()
    }
    
    
    fileprivate func categoryInit() {
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension PopularCategoriesDashboardCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        cell.layoutSubviews()
        if indexPath.row == 5 {
            cell.categoryImageView.image = UIImage(systemName: "plus")
            cell.categoryImageView.tintColor = WedAdviserColor.themeOrangeColor()
            cell.cateogryName.text = "All Types"
        } else {
            cell.categoryImageView.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + "popular_category/" + Helper.optionalStringToString(value: popularCategories?[indexPath.row].logo)), placeholderImage: nil)
            cell.cateogryName.text = Helper.optionalStringToString(value: popularCategories?[indexPath.row].name)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3 , height: collectionView.bounds.height / 2)
    }
}
