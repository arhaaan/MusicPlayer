//
//  ViewModel.swift
//  Music Player
//
//  Created by Karim Arhan on 17/05/25.
//

import Foundation
import AVFoundation

class ViewModel {
   var songs = [Song]() {
      didSet {
         onSongsUpdated?()
      }
   }
   var isLoading = false
   var searchText = ""
   
   //Player
   private var player: AVPlayer?
   private var currentItem: AVPlayerItem?
   
   var isPlaying = false
   
   private let service: WebService
   
   init( service: WebService) {
      self.service = service
   }
   
   var onSongsUpdated: (() -> Void)?
   
   func searchSongs() {
      guard !searchText.isEmpty else { return }
              
      isLoading = true
      
      service.findSongs(term: searchText) { [weak self] result in
         DispatchQueue.main.async {
            self?.isLoading = false
            
            switch result {
            case .success(let success):
               self?.songs = success.results
               print(success)
            case .failure(let failure):
               print(failure.localizedDescription)
               self?.songs = []
            }
         }
      }
   }
   
   func playSong(url: String) {
      guard let url = URL(string: url) else { return }
              
      let playerItem = AVPlayerItem(url: url)
      currentItem = playerItem
      player = AVPlayer(playerItem: playerItem)
              
//      playerItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status),options: [.old, .new], context: nil)
      
      player?.play()
      isPlaying.toggle()
   }
   
   func stop() {
      player?.pause()
      isPlaying.toggle()
   }
   
   func play() {
      player?.play()
      isPlaying.toggle()
   }
}
