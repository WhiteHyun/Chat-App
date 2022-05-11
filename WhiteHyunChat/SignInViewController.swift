//
//  SignInViewController.swift
//  WhiteHyunChat
//
//  Created by 홍승현 on 2022/05/10.
//

import UIKit

import Firebase

final class SignInViewController: UIViewController {
  
  private enum ColorConstants {
    
    static let `default` = UIColor(named: "Background Color")
    
    static let hover = UIColor.white
    
    static let point = UIColor(named: "Point Color")
    
  }
  
  
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var emailView: UIView!
  @IBOutlet weak var passwordView: UIView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    emailTextField.delegate = self
    passwordTextField.delegate = self
    updateUI()
  }
  
  
  @IBAction func loginButtonDidTap(_ sender: UIButton) {
    
    view.endEditing(true)
    
    // Email, Password 전부 기입되었는지 확인
    guard let email = emailTextField.text,
          let password = passwordTextField.text,
          !email.isEmpty,
          !password.isEmpty
    else {
      let alert = UIAlertController(
        title: "경고",
        message: "비어있는 항목이 있습니다!",
        preferredStyle: .alert
      )
      alert.addAction(UIAlertAction(title: "확인", style: .default))
      present(alert, animated: true)
      return
    }
    
    
    // Try Login
    Auth.auth().signIn(withEmail: email, password: password) { [unowned self] authResult, error in
      // Error?
      if let error = error {
        let alert = UIAlertController(
          title: "로그인 실패",
          message: "\(error.localizedDescription)",
          preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        DispatchQueue.main.async {
          self.present(alert, animated: true)
        }
      } else {
        self.navigationController?.popViewController(animated: true)
      }
    }
  }
  
  
  /// storyboard 내에 미처 못한 UI를 수정합니다.
  private func updateUI() {
    
    // round corners
    containerView.layer.cornerRadius = 8
    emailView.layer.cornerRadius = 8
    passwordView.layer.cornerRadius = 8
    loginButton.layer.cornerRadius = 8
    
    // drop shadows
    containerView.layer.shadowOpacity = 1
    containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
    containerView.layer.shadowRadius = 12
    containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    containerView.layer.masksToBounds = false
    
    // view shadows
    emailView.layer.shadowOffset = CGSize(width: 0, height: 0)
    emailView.layer.shadowRadius = 12
    emailView.layer.shadowColor = ColorConstants.default?.cgColor
    emailView.layer.masksToBounds = false
    emailView.layer.borderColor = ColorConstants.point?.cgColor
    
    passwordView.layer.shadowOffset = CGSize(width: 0, height: 0)
    passwordView.layer.shadowRadius = 12
    passwordView.layer.shadowColor = ColorConstants.default?.cgColor
    passwordView.layer.masksToBounds = false
    passwordView.layer.borderColor = ColorConstants.point?.cgColor
    
    
    updateViewUI(emailView, hovered: false)
    updateViewUI(passwordView, hovered: false)
  }
  
  
  /// textField를 감싸는 View의 상태를 업데이트합니다.
  /// 사용자가 textField를 터치한 경우 hovered 인자를 true로 받으면 됩니다.
  /// `hovered`상태인 경우, 선택된 것처럼 뷰의 상태가 바뀝니다.
  /// `default`상태인 경우, 본 View의 모습으로 돌아갑니다.
  private func updateViewUI(_ view: UIView, hovered: Bool) {
    if hovered {
      view.backgroundColor =  ColorConstants.hover
      view.layer.shadowOpacity = 1
      view.layer.borderWidth = 1
    } else {
      view.backgroundColor = ColorConstants.default
      view.layer.shadowOpacity = 0
      view.layer.borderWidth = 0
    }
  }
  
  
  /// textField를 감싸는 부모 View를 리턴합니다.
  private func parentView(of textField: UITextField) -> UIView {
    if emailView.subviews.contains(textField) {
      return emailView
    } else {
      return passwordView
    }
  }
}


extension SignInViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    let view = parentView(of: textField)
    updateViewUI(view, hovered: true)
  }
  
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    let view = parentView(of: textField)
    updateViewUI(view, hovered: false)
  }
}
