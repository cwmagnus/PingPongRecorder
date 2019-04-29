//
//  GamesVC.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/23/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit

// User games view controller
class GamesVC : UIViewController {

    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noGamesFound: UIStackView!
    @IBOutlet weak var gamesTable: UITableView!
    
    // Load the view
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set up table refresh control
        refreshControl.addTarget(self, action: #selector(refreshGamesContent(_:)), for: .valueChanged)
        gamesTable.addSubview(refreshControl)
        
        loadGameContent()
    }
    
    func loadGameContent() {
     
        
    }
    
    @objc func refreshGamesContent(_ sender: Any?) {
        
        
    }
    
    // Bring up the add a game screen
    @IBAction func onAddGameClick(_ sender: Any) {
        performSegue(withIdentifier: "AddGame", sender: self)
    }
}
