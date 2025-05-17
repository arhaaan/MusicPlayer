//
//  WebService.swift
//  Music Player
//
//  Created by Karim Arhan on 17/05/25.
//

import Foundation

class WebService {
   let baseUrl = "https://itunes.apple.com/search"
   
   func findSongs(term: String, completion: @escaping (Result<SongResponse, Error>) -> Void) {
      
      let formattedTerm = term.replacingOccurrences(of: " ", with: "+")
      let endpoint = "\(baseUrl)?term=\(formattedTerm)&media=music&entity=song&limit=50"
      
      guard let url = URL(string: endpoint) else {
         completion(.failure(NetworkError.invalidRequest))
         return
      }
      
      URLSession.shared.dataTask(with: url) { data, response, error in
         if let error = error {
            completion(.failure(error))
            return
         }
         
         if let data = data {
            do {
               let songResponse = try JSONDecoder().decode(SongResponse.self, from: data)
               completion(.success(songResponse))
            } catch {
               completion(.failure(error))
            }
         }
         
      }
      .resume()
   }
}

enum NetworkError: Error {
   case invalidRequest
}
