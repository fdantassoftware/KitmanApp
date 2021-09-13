//
//  LoginViewController.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // IBoutlets
    @IBOutlet var usernameField: KTextField!
    @IBOutlet var passwordField: KTextField!
    
    private let nextControllerId = "AthletesViewController"
    
    private var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.delegate = self
    }
    
    @IBAction func onLogin(_ sender: Any) {
        self.startLoadingAnimation(loadingMessage: nil)
        loginViewModel.login(username: usernameField.text ?? "", password: passwordField.text ?? "")
    }
    
    private func showNextController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destinationController = storyBoard.instantiateViewController(identifier: nextControllerId)
        destinationController.modalPresentationStyle = .fullScreen
        self.present(destinationController, animated: true, completion: nil)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func onLoginSuccess(username: String) {
        DispatchQueue.main.async {
            self.stopLoadingAnimation()
            self.showNextController()
        }
    }
    
    func onLoginFailed() {
        DispatchQueue.main.async {
            self.stopLoadingAnimation()
            self.showError(title: "Opss", message: "Something went wrong")
        }
    }
}
