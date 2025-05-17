//
//  SongTableViewCell.swift
//  Music Player
//
//  Created by Karim Arhan on 17/05/25.
//

import UIKit

class SongTableViewCell: UITableViewCell {
   
   @IBOutlet weak var artworkImageView: UIImageView!
   @IBOutlet weak var songNameLabel: UILabel!
   @IBOutlet weak var artistLabel: UILabel!
   @IBOutlet weak var albumLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
