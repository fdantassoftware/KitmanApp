//
//  UIViewController+Extension.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//


import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    func showError(title: String? = "", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension UIViewController: NVActivityIndicatorViewable {
    
    func startLoadingAnimation(loadingMessage: String?) {
        self.view.endEditing(true)
        let size = CGSize(width: 130, height: 130)
        let type = NVActivityIndicatorType.ballScaleMultiple
        startAnimating(size, message: loadingMessage, messageFont: UIFont(name: "Avenir-Medium", size: 20), type: type, color: UIColor().setRGB(r: 0, g: 226, b: 120), padding: 0, displayTimeThreshold: 0, minimumDisplayTime: 0, backgroundColor: nil, textColor: UIColor.white)
        
    }
    func stopLoadingAnimation() {
        self.stopAnimating()
    }
}
