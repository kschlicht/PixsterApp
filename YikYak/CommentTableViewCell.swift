
//  CommentTableViewCell.swift


import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
