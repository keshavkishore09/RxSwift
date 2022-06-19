//
//  PhotoCollectionViewCell.swift
//  Camera Filter
//
//  Created by Keshav Kishore on 18/06/22.
//

import UIKit



class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
