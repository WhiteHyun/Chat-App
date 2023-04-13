//
//  ChatTableViewCell.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/08.
//

import UIKit

class ChatListCell: UITableViewCell {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var currentChatLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var badgeLabel: UILabel!
  
  static let names = [
    "Kaylynn Vetrovs",
    "Paityn Carder",
    "Kierra Calzoni",
    "Madelyn Korsgaard",
    "Lydia Ekstrom Bothman",
    "Mira Schleifer",
    "Allison Press",
    "Erin Vetrovs"
  ]
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func updateUI(index: Int) {
    profileImageView.image = UIImage(named: "Person\(index + 1)")
    profileImageView.layer.cornerRadius = 0.5 * profileImageView.bounds.size.width
    
    // statusLabel.clipsToBounds = true
    statusLabel.layer.cornerRadius = 0.5 * statusLabel.bounds.size.width
    statusLabel.backgroundColor = UIColor(named: StatusColor.allCases.randomElement()!.rawValue)
    statusLabel.layer.borderWidth = 2
    statusLabel.layer.borderColor = UIColor.white.cgColor
    
    nameLabel.text = ChatListCell.names.randomElement()
    
    currentChatLabel.text = "Lorem ipsum dolor sit amet, cons..."
    
    timeLabel.text = "11:00"
    
    // badgeLabel.clipsToBounds = true
    badgeLabel.text = "\(index + 1)"
    badgeLabel.layer.cornerRadius = 0.5 * badgeLabel.bounds.size.width
    badgeLabel.backgroundColor = UIColor(red: 0.078, green: 0.839, blue: 0.518, alpha: 1)
    
    
    
  }
  
}

extension ChatListCell {
  
  enum StatusColor: String, CaseIterable {
    case online = "Online Color"
    case offline = "Offline Color"
    case doNotDisturb = "Do Not Disturb Color"
    case idle = "Idle Color"
  }
}
