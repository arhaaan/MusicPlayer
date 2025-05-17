//
//  Song.swift
//  Music Player
//
//  Created by Karim Arhan on 17/05/25.
//

import Foundation

struct Song: Codable ,Identifiable {
   let id = UUID()
      let trackId: Int
      let artistName: String
      let trackName: String
      let previewUrl: String
      let artworkUrl100: String
      let collectionName: String?
      
      enum CodingKeys: String, CodingKey {
         case  trackId, artistName, trackName, previewUrl, artworkUrl100, collectionName
      }
}

struct SongResponse: Codable {
   let results: [Song]
}
