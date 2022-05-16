//
//  ChatCell.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/10.
//

import UIKit

class MessageCell: UITableViewCell {
  
  
  //MARK: - IBOutlet Part
  
  @IBOutlet weak var leftView: UIView!
  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var rightView: UIView!
  @IBOutlet weak var successImageView: UIImageView!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  
  //MARK: - Constants Part
  
  static let cellIdentifier = "ReusableCell"
  static let cellNibName = "MessageCell"
  
  //MARK: - Function Part
  
  func configureMyMessageCell() {
    leftView.isHidden = false
    rightView.isHidden = true
    messageBubble.backgroundColor = ChatConstants.currentUserBackgroundColor
    messageBubble.layer.maskedCorners = [
      .layerMaxXMinYCorner,
      .layerMinXMinYCorner,
      .layerMinXMaxYCorner
    ]
    timeLabel.textColor = ChatConstants.currentUserPointColor
    successImageView.isHidden = false
  }
  
  
  func configureOtherMessageCell() {
    leftView.isHidden = true
    rightView.isHidden = false
    messageBubble.backgroundColor = ChatConstants.anotherUserBackgroundColor
    messageBubble.layer.maskedCorners = [
      .layerMaxXMinYCorner,
      .layerMinXMinYCorner,
      .layerMaxXMaxYCorner
    ]
    timeLabel.textColor = ChatConstants.anotherUserPointColor
    successImageView.isHidden = true
  }
}
