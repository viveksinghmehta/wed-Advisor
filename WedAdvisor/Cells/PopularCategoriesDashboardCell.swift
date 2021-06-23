//
//  PopularCategoriesDashboardCell.swift
//  WedAdvisor
//
//  Created by Vivek Singh Mehta on 22/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

protocol PopularCategoryDelegate: NSObject {
    func categorySelected(selected: Int, IndexPath: IndexPath)
}

class PopularCategoriesDashboardCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var popularCategories: [HomeVendorType]?
    var index: IndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: PopularCategoryDelegate?
    private let identifier: String = "categoryCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryInit()
    }
    
    
    fileprivate func categoryInit() {
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.categorySelected(selected: indexPath.row, IndexPath: index)
    }
}
