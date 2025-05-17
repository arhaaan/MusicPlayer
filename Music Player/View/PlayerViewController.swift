//
//  PlayerViewController.swift
//  Music Player
//
//  Created by Karim Arhan on 17/05/25.
//

import UIKit

class PlayerViewController: UIViewController {

   @IBOutlet weak var searchBar: UISearchBar!
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var playerControlView: UIView!
   @IBOutlet weak var playButton: UIButton!
   @IBOutlet weak var slider: UISlider!
   
   override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


   @IBAction func prevButtonTapped(_ sender: Any) {
   }
   
   @IBAction func playButtonTapped(_ sender: Any) {
   }
   
   @IBAction func nextButtonTapped(_ sender: Any) {
   }
}
