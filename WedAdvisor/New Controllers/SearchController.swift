//
//  SearchController.swift
//  WedAdvisor
//
//  Created by WishACloud on 03/07/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

final class SearchController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    private let headerIdentifier: String = "headerCell"
    private let identifier: String = "searchCell"
    
    private var searchResultModel: SearchModel?
    private var isSearchStarted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarInit()
        tableViewInit()
    }

    fileprivate func searchBarInit() {
        searchBar.delegate = self
    }
    
    
    fileprivate func tableViewInit() {
        searchTableView.register(UINib(nibName: "SearchHeaderCell", bundle: nil), forCellReuseIdentifier: headerIdentifier)
        searchTableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: identifier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.tableFooterView = UIView()
    }
    
    fileprivate func searchApi(text: String) {
        let param: [String: Any] = ["data": text]
        self.showActivityIndicator(uiView: self.view)
        APIManager.sharedInstance.search(with: param) { [weak self] model in
            guard let weakself = self else { return }
            weakself.isSearchStarted = true
            weakself.hideActivityIndicator(uiView: weakself.view)
            weakself.searchResultModel = model
            weakself.searchTableView.reloadData()
        } failure: { [weak self] error in
            guard let weakself = self else { return }
            weakself.hideActivityIndicator(uiView: weakself.view)
            weakself.showAlertWithOk(title: "Error", message: Helper.optionalStringToString(value: error?.msg))
        }

    }
    
    
    

}

extension SearchController: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchApi(text: Helper.optionalStringToString(value: searchBar.text))
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.layoutIfNeeded()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearchStarted {
            return 3
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { // Vendors Type
            return Helper.optionalIntToInt(value: searchResultModel?.vendorType?.count) + 1
        } else if section == 1 { // locations
            return Helper.optionalIntToInt(value: searchResultModel?.location?.count) + 1
        } else if section == 2 { // vendors
            return Helper.optionalIntToInt(value: searchResultModel?.searchvendor?.count) + 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SearchCell, let headerCell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier, for: indexPath) as? SearchHeaderCell else { return UITableViewCell() }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                headerCell.headingLabel.text = "Vendor Type"
                return headerCell
            } else {
                cell.searchLabel.text = Helper.optionalStringToString(value: searchResultModel?.vendorType?[indexPath.row - 1].name)
                return cell
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                headerCell.headingLabel.text = "Location"
                return headerCell
            } else {
                cell.searchLabel.text = Helper.optionalStringToString(value: searchResultModel?.location?[indexPath.row - 1].city)
                return cell
            }
        } else {
            if indexPath.row == 0 {
                headerCell.headingLabel.text = "Vendors"
                return headerCell
            } else {
                cell.searchLabel.text = Helper.optionalStringToString(value: searchResultModel?.searchvendor?[indexPath.row  - 1].name)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 { // vendor type
            if indexPath.row != 0 {
                vendorType(indexPath.row - 1)
            }
        } else if indexPath.section == 1 { // location
            if indexPath.row != 0 {
                location(indexPath.row - 1)
            }
        } else { // vendors
            if indexPath.row != 0 {
                vendor(indexPath.row - 1)
            }
        }
    }
    
    
    fileprivate func vendorType(_ index: Int) {
        print(searchResultModel?.vendorType?[index].name)
    }
    
    fileprivate func location(_ index: Int) {
        print(searchResultModel?.location?[index].city)
    }
    
    fileprivate func vendor(_ index: Int) {
        print(searchResultModel?.searchvendor?[index].name)
    }
    
}
