//
//  WeddingTippsCell.swift
//  WedAdvisor
//
//  Created by WishACloud on 23/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit
import SDWebImage

protocol WeddingTipsDelegate: NSObject {
    func weddingTipSelected(selected: Int, indexPath: IndexPath)
}

class WeddingTippsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var weddingCollectionView: UICollectionView!
    
    var weddingTipsAndNews: [GetweddTipsNews]?
    var index: IndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: WeddingTipsDelegate?
    private let identifier: String = "WeddingAffairsCollectionCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreButton.layer.cornerRadius = 5
        moreButton.layer.masksToBounds = true
        collectionInit()
    }
    
    
    fileprivate func collectionInit() {
        weddingCollectionView.register(UINib(nibName: "WeddingAffairsCollectionCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        weddingCollectionView.delegate = self
        weddingCollectionView.dataSource = self
        weddingCollectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func moreAction(_ sender: UIButton) {
        print("more action")
    }
    
    
}

extension WeddingTippsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let value = weddingTipsAndNews {
            return value.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath) as? WeddingAffairsCollectionCell else { return UICollectionViewCell() }
        cell.imgImage.sd_setImage(with: URL(string: GlobalConstantClass.APIConstantNames.imageBaseURL + Helper.optionalStringToString(value: weddingTipsAndNews?[indexPath.row].cover_image)))
        cell.lblName.text = Helper.optionalStringToString(value: weddingTipsAndNews?[indexPath.row].title)
        cell.lblCity.text = Helper.optionalStringToString(value: weddingTipsAndNews?[indexPath.row].short_description).html2String
        cell.lblRequest.text = Helper.optionalStringToString(value: weddingTipsAndNews?[indexPath.row].author).uppercased()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width) / 1.2
        let hgt = (collectionView.bounds.height)
        return CGSize(width: size, height: hgt)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegate?.weddingTipSelected(selected: indexPath.row, indexPath: index)
    }
    
}
