//
//  ChatCell.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/10.
//

import UIKit

class MessageCell: UITableViewCell {
  
  @IBOutlet weak var leftView: UIView!
  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var rightView: UIView!
  
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
//
//  override func layoutSubviews() {
//    super.layoutSubviews()
//    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0))
//  }
//  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
