//
//  UIAlertController+Additions.swift
//  RMBT
//
//  Created by Sergey Glushchenko on 27.10.2021.
//  Copyright © 2021 appscape gmbh. All rights reserved.
//

import UIKit

typealias AlertAction = ((UIAlertAction) -> Void)?
typealias AlertGetTextAction = ((UITextField) -> Void)?
typealias GenericCompletition = (() -> Void)?

extension UIAlertController {
    @discardableResult class func presentAlert(title: String?, text: String?, _ dismissAction: AlertAction) -> UIAlertController? {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction.genericCancelAction(dismissAction))
        alert.show()
        return alert
    }
    
    class func presentAlertDevCode(_ dismissAction: AlertAction, codeAction: AlertGetTextAction, textFieldConfiguration: AlertGetTextAction) -> UIAlertController? {
        
        let alert = UIAlertController(title: .devCodeTitle, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.genericCancelAction(dismissAction))
        alert.addAction(UIAlertAction.synchEnterCodeAction({ [weak alert] (action) in
            if alert?.textFields?.count ?? 0 > 0,
                let textField = alert?.textFields?[0] {
                codeAction?(textField)
            }
        }))
        
        alert.addTextField(configurationHandler: textFieldConfiguration)
        alert.show()
        
        return alert
    }
    
    // main function to show
    private func show() {
        present(true, completion: nil)
    }
    
    // main function to present
    private func present(_ animated: Bool, completion: GenericCompletition) {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            presentFromController(rootVC, animated: animated, completion: completion)
        }
    }
    
    private func presentFromController(_ controller: UIViewController, animated: Bool, completion: GenericCompletition) {
        if  let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
            presentFromController(visibleVC, animated: animated, completion: completion)
        } else {
            if  let tabVC = controller as? UITabBarController,
                let selectedVC = tabVC.selectedViewController {
                presentFromController(selectedVC, animated: animated, completion: completion)
            } else {
                controller.present(self, animated: animated, completion: completion)
            }
        }
    }
}

extension UIAlertAction {
    class func genericCancelAction(_ performAction: AlertAction) -> UIAlertAction {
        return UIAlertAction(title: .cancel, style: .cancel, handler: performAction)
    }
    
    class func synchEnterCodeAction(_ performAction: AlertAction) -> UIAlertAction {
        return UIAlertAction(title: .enterCode, style: .default, handler: performAction)
    }
}

private extension String {
    static let devCodeTitle = NSLocalizedString("preferences_enter_code", comment: "")
    static let cancel = NSLocalizedString("input_setting_dialog_cancel", comment: "")
    static let enterCode = NSLocalizedString("button_sync_enter_code", comment: "")
}
