//
//  GamesVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/23/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit
import Alamofire

// User games view controller
class GamesVC : UIViewController, UITableViewDataSource {

    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noGamesFound: UIStackView!
    @IBOutlet weak var gamesTable: UITableView!
    private var data: [Game] = []
    
    // Load the view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set up table and load initial content
        refreshControl.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
        gamesTable.dataSource = self
        gamesTable.addSubview(refreshControl)
        loadGameContent()
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GameCell
        cell.setup(game: data[indexPath.row])
        return cell
    }
    
    // Load game content
    private func loadGameContent() {
        
        data = []
        noGamesFound.isHidden = true
        gamesTable.isHidden = true
        loadingIndicator.startAnimating()
        
        // Make the get request for the games list
        let headers = [
            "Authorization": "Bearer \(Authentication.accessToken ?? "invalid token")",
            "Content-Type": "application/json"
        ]
     
        request("https://ping-pong-recorder-api.herokuapp.com/games", method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: loadGamesCallback)
    }
    
    // Called when finished loading
    private func loadGamesCallback(response: DataResponse<Any>) {
        
        if let jsonResponse = response.result.value as? [String: Any?] {
            
            if response.response?.statusCode == 200 {
                
                // Add games loaded to the table
                if let games = jsonResponse["games"] as? [[String: Any?]] {
                    
                    for game in games {
                        
                        data.append(Game(title: game["name"] as? String, userScore: game["user_score"] as? Int, opponentScore: game["opponent_score"] as? Int))
                    }
                }
                gamesTable.reloadData()
            }
            else {
                // Show an error message
            }
        }
        
        // If there is data then show the table otherwise show no games found
        if data.count > 0 {
            
            gamesTable.isHidden = false
            loadingIndicator.stopAnimating()
            refreshControl.endRefreshing()
        }
        else {
            
            loadingIndicator.stopAnimating()
            refreshControl.endRefreshing()
            noGamesFound.isHidden = false
        }
    }
    
    // Refresh the table by pulling down
    @objc private func refreshTable(_ sender: Any) {
        
        loadGameContent()
    }
    
    // Bring up the add a game screen
    @IBAction func onAddGameClick(_ sender: Any) {
        
        performSegue(withIdentifier: "AddGame", sender: self)
    }
}
