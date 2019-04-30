//
//  LeaderboardVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/23/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit
import Alamofire

// Leaderboard view controller
class LeaderboardVC : UIViewController, UITableViewDataSource {

    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noUsersFound: UIStackView!
    @IBOutlet weak var leaderBoardTable: UITableView!
    private var data: [User] = []
    
    // Load the view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set up table and load initial content
        refreshControl.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
        leaderBoardTable.dataSource = self
        leaderBoardTable.addSubview(refreshControl)
        loadUserContent()
    }
    
    // Get the number of sections in a row
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // Get the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    // Return the cell at the index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell") as! LeaderBoardCell
        cell.setup(user: data[indexPath.row])
        return cell
    }
    
    // Load game content
    private func loadUserContent() {
        
        data = []
        noUsersFound.isHidden = true
        leaderBoardTable.isHidden = true
        loadingIndicator.startAnimating()
        
        // Make the get request for the games list
        let headers = [
            "Authorization": "Bearer \(Authentication.accessToken ?? "invalid token")",
            "Content-Type": "application/json"
        ]
        
        request("https://ping-pong-recorder-api.herokuapp.com/user-list", method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: loadGamesCallback)
    }
    
    // Called when finished loading
    private func loadGamesCallback(response: DataResponse<Any>) {
        
        if let jsonResponse = response.result.value as? [String: Any?] {
            
            if response.response?.statusCode == 200 {
                
                // Add games loaded to the table
                if let users = jsonResponse["users"] as? [[String: Any?]] {
                    
                    for user in users {
                        
                        data.append(User(username: user["username"] as? String, wins: user["wins"] as? Int, losses: user["losses"] as? Int))
                    }
                }
                leaderBoardTable.reloadData()
            }
            else {
                // Show an error message
                let errorAlert = UIAlertController(title: "Error Loading Leaderboard", message: jsonResponse["message"] as? String, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        
        // If there is data then show the table otherwise show no games found
        if data.count > 0 {
            
            leaderBoardTable.isHidden = false
            loadingIndicator.stopAnimating()
            refreshControl.endRefreshing()
        }
        else {
            
            loadingIndicator.stopAnimating()
            refreshControl.endRefreshing()
            noUsersFound.isHidden = false
        }
    }
    
    // Refresh the table by pulling down
    @objc private func refreshTable(_ sender: Any) {
        
        loadUserContent()
    }
}
