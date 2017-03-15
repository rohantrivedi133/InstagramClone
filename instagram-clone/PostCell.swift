//
//  PostCell.swift
//  instagram-clone
//
//  Created by Rohan Trivedi on 3/5/17.
//  Copyright © 2017 Rohan Trivedi. All rights reserved.
//

import UIKit
import ParseUI

class PostCell: UITableViewCell
{
    
    @IBOutlet weak var postPFImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: PFObject!
        {
        didSet
        {
            self.postPFImageView.file = post["media"] as? PFFile
            self.postPFImageView.loadInBackground()
            self.captionLabel.text = post["caption"] as? String
        }
    }
    
}
