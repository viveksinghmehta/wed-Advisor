//
//  TestimonialDashboardCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 23/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SDWebImage

class TestimonialDashboardCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var testimonialCollectionView: UICollectionView!
    private let identifier: String = "TestimonialCell"
    var testionomials: [GetTestimonial]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionInit()
    }
    
    fileprivate func collectionInit() {
        testimonialCollectionView.register(UINib(nibName: "TestimonialCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        testimonialCollectionView.delegate = self
        testimonialCollectionView.dataSource = self
        testimonialCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension TestimonialDashboardCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let value = testionomials {
           return value.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestimonialCell", for: indexPath as IndexPath) as? TestimonialCell else { return UICollectionViewCell() }
        cell.imgImage.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + Helper.optionalStringToString(value: testionomials?[indexPath.row].profile_image)))
        cell.lblComment.text = Helper.optionalStringToString(value: testionomials?[indexPath.row].comment)
        cell.lblName.text = Helper.optionalStringToString(value: testionomials?[indexPath.row].name)
        cell.lblProfession.text = Helper.optionalStringToString(value: testionomials?[indexPath.row].profession)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width) / 1.2
        let hgt = (collectionView.bounds.height - 10)
        return CGSize(width: size, height: hgt)
    }
    
    
    
    
}
