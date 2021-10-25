//
//  UIViewController+ModalBrowser.swift
//  RMBT
//
//  Created by Sergey Glushchenko on 26.07.2021.
//  Copyright © 2021 appscape gmbh. All rights reserved.
//

import Foundation

extension UIViewController {
    // Presents a modal web browser with supplied URL. If there are occurences of
    // $lang in the URL, those are replaced with either "de" or "en", depending on
    // preferrred language
    
    @objc(presentModalBrowserWithURLString:)
    func presentModalBrowser(with url: String) {
        guard let webViewController = RMBTModalWebViewController(address: RMBTLocalizeURLString(url)) else { return }
        webViewController.barsTintColor = .tintColor
        self.present(webViewController, animated: true, completion: nil)
    }
}

private extension UIColor {
    static let tintColor = UIColor(named: "tintColor")
}
