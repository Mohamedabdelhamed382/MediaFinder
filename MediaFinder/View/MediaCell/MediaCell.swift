//
//  MoviesCell.swift
//  MediaFinder
//
//  Created by Mohamed Abdelhamed Ahmed on 1/2/21.
//  Copyright © 2021 Mohamed Abdelhamed Ahmed. All rights reserved.
//

import UIKit
class MediaCell: UITableViewCell {
    //MARK :- Outlet
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var mediaNameLabelFirst: UILabel!
    @IBOutlet weak var mediaNameLabelSecond: UITextView!
    @IBOutlet weak var imageAnimateBtn: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    //MARK:- Life Cycle
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK:- configure Function to put data into cell
    func configure(mediaType: MediaType, media: Media ){
        switch mediaType {
        case .music:
            mediaNameLabelFirst.text = media.trackName!
            mediaNameLabelSecond.text = media.artistName
            self.label1.text = labelsKeys.trackNameLabel
            self.label2.text = labelsKeys.artistName
        case .movie :
            mediaNameLabelFirst.text = media.trackName!
            mediaNameLabelSecond.text = media.longDescription ?? "no longer data founed"
            self.label1.text = labelsKeys.trackNameLabel
            self.label2.text = labelsKeys.longDescriptionLabel
        case .tvShow :
            mediaNameLabelFirst.text = media.artistName
            mediaNameLabelSecond.text = media.longDescription ?? "no longer data founed"
            self.label1.text = labelsKeys.artistName
            self.label2.text = labelsKeys.longDescriptionLabel
        }
        if let image = getImage(from: media.artworkUrl100) {
            mediaImageView.image = image
        }
    }
    // MARK:- Action
    @IBAction func imageAnimateBtntapped(_ sender: UIButton) {
        animation()
    }
}
// MARK:- Private Function 
extension MediaCell {
    private func animation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.mediaImageView.transform = CGAffineTransform.identity.scaledBy(x: 0.6, y: 0.6)
        }, completion: { (finish) in
            UIView.animate(withDuration: 0.20, animations: {
                self.mediaImageView.transform = CGAffineTransform.identity
            })
        })
    }
    private func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }
        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])
            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }
        return image
    }
}

