//
//  MessageTableViewCell.swift
//  APP-FlashChat
//
//  Created by José Eduardo Rodríguez Reyes on 18/07/21.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // a medida que el mensaje crezca el corner radius se adapta a su altura
        self.messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
