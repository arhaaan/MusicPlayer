//
//  PlayerViewController.swift
//  Music Player
//
//  Created by Karim Arhan on 17/05/25.
//

import UIKit

class PlayerViewController: UIViewController {

   @IBOutlet weak var searchTextField: UITextField!
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var playerControlView: UIView!
   @IBOutlet weak var playButton: UIButton!
//   @IBOutlet weak var slider: UISlider!
   
   private let vm : ViewModel
   
   init(vm: ViewModel) {
      self.vm = vm
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
        super.viewDidLoad()
      
      searchTextField.delegate = self
      searchTextField.returnKeyType = .search

      vm.onSongsUpdated = { [weak self] in
         DispatchQueue.main.async {
            self?.tableView.reloadData()
         }
      }
    }
      
   @IBAction func searchEditingChanged(_ sender: Any) {
      if let text = searchTextField.text {
         vm.searchText = text
         print(vm.searchText)
      }
   }
   
//   @IBAction func searchDidEnd(_ sender: Any) {
//      vm.searchSongs()
//   }
   
   @IBAction func prevButtonTapped(_ sender: Any) {
   }
   
   @IBAction func playButtonTapped(_ sender: Any) {
   }
   
   @IBAction func nextButtonTapped(_ sender: Any) {
   }
}

extension PlayerViewController: UITextFieldDelegate {
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      vm.searchSongs()
      return true
   }
}
