//
//  CollectionTableViewCell.swift
//  Sports
//
//  Created by Ahmed on 3/30/21.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTitle: PaddingLabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
