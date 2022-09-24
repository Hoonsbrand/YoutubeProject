//
//  VideoCell.swift
//  YoutubePlayer
//
//  Created by hoonsbrand on 2022/09/20.
//

import UIKit

class VideoCell: UICollectionViewCell {

    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var statisticsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func getTitle(title: String) {
        videoTitle.text = title
    }

}
