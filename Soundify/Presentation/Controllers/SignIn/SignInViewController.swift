//
//  SignInViewController.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import UIKit
import WebKit

class SignInViewController: UIViewController {
  public var completionHandler: ((Bool) -> Void)?
  
  lazy var signInView: SignInView = {
    let view = SignInView()
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Sign In"
    
    guard let url = AuthenticationManager.shared.signInURL else { return }
    signInView.load(URLRequest(url: url))
  }
  
  override func loadView() {
    super.loadView()
    view = signInView
    
    signInView.navigationDelegate = self
  }
}

extension SignInViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    Task.detached {
      guard let url = await webView.url else { return }
      
      guard let code = URLComponents(
        string: url.absoluteString
      )?.queryItems?.first(where: { $0.name == "code" })?.value else {
        return
      }
      await self.setHiddenWebView()
      
      let success = await RemoteAuthentication().auth(code: code)
      
      await self.completionHandler?(success)
      await self.navigationController?.popToRootViewController(animated: true)
    }
  }
}

extension SignInViewController {
  private func setHiddenWebView() {
    signInView.isHidden = true
  }
}
