//
//  UIViewController.swift
//  TMDb-Challenge
//
//  Created by John Allen Santos Coimbra on 06/02/22.
//

import UIKit

extension UIViewController {
    
    func onPop(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func onPopToRoot(animated: Bool) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
    func onPopToController(_ viewController: UIViewController, animated: Bool) {
        self.navigationController?.popToViewController(viewController, animated: animated)
    }
    
    func onDismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }
    
    func onDismissController(animated: Bool) {
        self.navigationController?.dismiss(animated: animated, completion: nil)
    }
    
    func push(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func model (_ viewController: UIViewController, animated: Bool = false, completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(viewController, animated: animated, completion: completion)
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
