//
//  ViewModel.swift
//  Music Player
//
//  Created by Karim Arhan on 17/05/25.
//

import Foundation

class ViewModel {
   var songs = [Song]() {
      didSet {
         onSongsUpdated?()
      }
   }
   var isLoading = false
   var searchText = ""
   
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
}
