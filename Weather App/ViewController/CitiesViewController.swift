//
//  CitiesViewController.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class CitiesViewController: BaseViewController {
    
    let dataSource = CitiesTableViewDS()
    
    // MARK: - Gui variables
    
    private lazy var searchBar: UISearchController = {
        let search = UISearchController()
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.definesPresentationContext = true
        search.searchBar.placeholder = "Search City"
        return search
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundView = backgroundImage
        tv.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tv.dataSource = dataSource
        tv.delegate = dataSource
        return tv
    }()
    
    private lazy var backgroundImage = BackgroundImage(frame: .zero)
    
    private func setupViews() {
        self.navigationItem.searchController = searchBar
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
}

// MARK: - Extensions

extension CitiesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = self.searchBar.searchBar.text, text.count > 3 else {
            return
        }
    }
}
