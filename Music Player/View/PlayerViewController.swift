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
      
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "SongTableViewCell")
      
    }
      
   @IBAction func searchEditingChanged(_ sender: Any) {
      if let text = searchTextField.text {
         vm.searchText = text
         print(vm.searchText)
      }
   }

   
   @IBAction func prevButtonTapped(_ sender: Any) {
   }
   
   @IBAction func playButtonTapped(_ sender: Any) {
      if vm.isPlaying {
         vm.stop()
      } else {
         vm.play()
      }
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

extension PlayerViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return vm.songs.count
       }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
      cell.artworkImageView.load(url: URL(string: vm.songs[indexPath.row].artworkUrl100)!)
      cell.songNameLabel.text = vm.songs[indexPath.row].trackName
      cell.artistLabel.text = vm.songs[indexPath.row].artistName
      cell.albumLabel.text = vm.songs[indexPath.row].collectionName
      
      return cell
       }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      playerControlView.isHidden = false
      let songUrlString = vm.songs[indexPath.row].previewUrl
      vm.playSong(url: songUrlString)
   }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
