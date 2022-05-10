//
//  SignUpViewController.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/10.
//

import UIKit

final class SignUpViewController: UIViewController {
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var emailView: UIView!
  @IBOutlet weak var passwordView: UIView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var submitButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  /// storyboard 내에 미처 못한 UI를 수정합니다.
  private func updateUI() {
    
    // round corners
    containerView.layer.cornerRadius = 8
    emailView.layer.cornerRadius = 8
    passwordView.layer.cornerRadius = 8
    submitButton.layer.cornerRadius = 8
    
    // drop shadows
    containerView.layer.shadowOpacity = 1
    containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
    containerView.layer.shadowRadius = 12
    containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    containerView.layer.masksToBounds = false
  }
}
