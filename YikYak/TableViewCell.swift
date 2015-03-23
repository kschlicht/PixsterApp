
//  TableViewCell.swift

import UIKit

class TableViewCell: PFTableViewCell {

    
    @IBOutlet weak var parseImage: UIImageView!
    @IBOutlet weak var parseText: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var replies: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    
    
    
}
