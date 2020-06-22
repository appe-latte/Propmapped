//
//  LoadingSpinner.swift
//  Propmapped
//
//  Created by James Jamarsoft on 24/11/2019.
//  Copyright © 2019 Propmapped. All rights reserved.
//

import UIKit

class LoadingSpinner: NSObject {
    
    private let spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showActivityIndicatory(uiView: UIView) {
        spinner.frame = CGRect(x:0.0, y:0.0, width:75.0, height:75.0);
        spinner.center = uiView.center
        spinner.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            spinner.style = UIActivityIndicatorView.Style.large
        } else {
            // Fallback on earlier versions
        }
        spinner.backgroundColor = .white
        spinner.layer.cornerRadius = 20
        spinner.color = UIColor(red:1.00, green:0.56, blue:0.55, alpha:1.0)
        uiView.addSubview(spinner)
        spinner.startAnimating()
    }
    
    func stopAnimatingIndicator() {
        spinner.stopAnimating();
    }
    
    func isAnimating() -> Bool {
        return spinner.isAnimating;
    }
}
