//
//  LoginViewModel.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func onLoginSuccess(username: String)
    func onLoginFailed()
}

class LoginViewModel: NSObject {
    
    weak var delegate: LoginViewModelDelegate?
    
    override init() {
        super.init()
    }
    
    func login(username: String, password: String) {
        
        guard let url = URL(string: API.shared.login) else {
            print("Unable to get a valid login endpoint")
            return
        }
        
        // Some validation could have been done around the textFields
        
        NetworkManager.post(url: url, parameters: ["username":username, "password":password]) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Login Failed. Error: \(error.localizedDescription)")
                self?.delegate?.onLoginFailed()
            case .success(let data):
                self?.handleLoginResponse(data: data)
            }
        }
    }
    
    private func handleLoginResponse(data: Data) {
        JsonParser.parseData(data) { [weak self] (result: ParseResult<Login>) in
            switch result {
            case .failure(let error):
                print("JSON Parsing failed: \(error)")
                self?.delegate?.onLoginFailed()
            case .success(let login):
                UserDefaults.standard.setValue(true, forKey: "isUserLogged")
                self?.delegate?.onLoginSuccess(username: login.username)
            }
        }
    }
    
}
