//
//  AthletesViewController.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//

import UIKit


class AthletesViewController: UIViewController {
    
    // Outlets
    @IBOutlet var tableView: UITableView!
    
    // Private Members
    private var athleteViewModel = AthleteViewModel()
    private var athletes = [Athlete]()
    private var squads = [Squad]()
    private let cellId = "AthleteCell"
    private let spinner = UIActivityIndicatorView(style: .large)
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(self.onRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.backgroundView = spinner
        tableView.tableFooterView = UIView()
        athleteViewModel.delegate = self
        spinner.startAnimating()
        athleteViewModel.bootstrap()
    }
    
    @objc func onRefresh() {
        // Could have some mechanism to add to existing array only if elements differ as oppose to fetch the whole list again
        athleteViewModel.bootstrap()
    }
    
}

extension AthletesViewController: AthleteViewModelDelegate {
    
    func onAthletesArrived(athletes: [Athlete]) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.spinner.stopAnimating()
            self.athletes = athletes
            self.tableView.reloadData()
        }
    }
    
    func onFetchFailed() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.spinner.stopAnimating()
            self.showError(title: "Opss", message: "Something went wrong")
        }
    }
    
}

extension AthletesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AthleteCell else {
            return UITableViewCell()
        }
        var athlete = athletes[indexPath.row]
        athlete.squads = athleteViewModel.getSquadsNamesForAthlete(ids: athlete.squad_ids)
        cell.update(athlete: athlete)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
