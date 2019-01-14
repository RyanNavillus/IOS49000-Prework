//
//  TipOptionsViewController.swift
//  tippy
//
//  Created by Ryan Sullivan on 1/9/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

class TipOptionsViewController: UIViewController {
    @IBOutlet weak var option1TextField: UITextField!
    @IBOutlet weak var option2TextField: UITextField!
    @IBOutlet weak var option3TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        var option1 = defaults.string(forKey: "option1")
        option1?.removeLast()
        var option2 = defaults.string(forKey: "option2")
        option2?.removeLast()
        var option3 = defaults.string(forKey: "option3")
        option3?.removeLast()
        option1TextField.placeholder = option1
        option2TextField.placeholder = option2
        option3TextField.placeholder = option3
        
        option1TextField.keyboardType = .decimalPad
        option2TextField.keyboardType = .decimalPad
        option3TextField.keyboardType = .decimalPad

        option1TextField.delegate = self
        option2TextField.delegate = self
        option3TextField.delegate = self

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = UserDefaults.standard
        var option1 = option1TextField.text
        if option1 == "" {
            option1 = defaults.string(forKey: "option1") ?? "0%"
            option1?.removeLast()
        }
        option1 = String(Double(option1 ?? "0") ?? 0)
        option1?.append("%")
        var option2 = option2TextField.text
        if option2 == "" {
            option2 = defaults.string(forKey: "option2") ?? "0%"
            option2?.removeLast()
        }
        option2 = String(Double(option2 ?? "0") ?? 0)
        option2?.append("%")

        var option3 = option3TextField.text
        if option3 == "" {
            option3 = defaults.string(forKey: "option3") ?? "0%"
            option3?.removeLast()
        }
        option3 = String(Double(option3 ?? "0") ?? 0)
        option3?.append("%")
        
        defaults.set(option1, forKey: "option1")
        defaults.set(option2, forKey: "option2")
        defaults.set(option3, forKey: "option3")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTheme()
    }
    
    func loadTheme() {
        let defaults = UserDefaults.standard
        let theme = defaults.string(forKey: "theme")
        if theme == "Light" {
            disableDarkMode()
        }
        else if theme == "Dark" {
            enableDarkMode()
        }
        for item in navigationController?.navigationBar.items ?? [] {
            item.titleView?.backgroundColor = navigationController?.navigationBar.backgroundColor
            item.titleView?.tintColor = navigationController?.navigationBar.tintColor
        }
    }
    
    
    func enableDarkMode() {
        option1TextField.keyboardAppearance = .dark
        option2TextField.keyboardAppearance = .dark
        option3TextField.keyboardAppearance = .dark

        view.backgroundColor = .darkSecondaryBackgroundColor
        view.tintColor = .darkTintColor
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkTextColor]
        for option in view.subviews {
            option.backgroundColor = .darkPrimaryBackgroundColor
            for subview in option.subviews {
                subview.backgroundColor = .darkPrimaryBackgroundColor
                subview.tintColor = .darkTintColor
                if let label = subview as? UILabel {
                    label.textColor = .darkTextColor
                }
                if let textField = subview as? UITextField {
                    textField.backgroundColor = .darkSecondaryBackgroundColor
                    textField.textColor = .darkTextColor
                }
                if subview.frame.height == 1 {
                    subview.backgroundColor = .darkSecondaryBackgroundColor
                }
            }
        }
    }
    
    func disableDarkMode() {
        option1TextField.keyboardAppearance = .default
        option2TextField.keyboardAppearance = .default
        option3TextField.keyboardAppearance = .default
        
        view.backgroundColor = .lightPrimaryBackgroundColor
        view.tintColor = .lightTintColor
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightTextColor]
        for view in view.subviews {
            view.backgroundColor = .lightPrimaryBackgroundColor
            view.tintColor = .lightTintColor
            if let label = view as? UILabel {
                label.textColor = .lightTextColor
            }
            if let textField = view as? UITextField {
                textField.backgroundColor = .lightSecondaryBackgroundColor
                textField.textColor = .lightTextColor
            }
            if view.frame.height == 1 {
                view.backgroundColor = .lightSecondaryBackgroundColor
            }
        }
    }
}

extension TipOptionsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var updatedString: NSString = (textField.text ?? "0") as NSString
        updatedString = updatedString.replacingCharacters(in: range, with: string) as NSString
        let realString = updatedString as String
        if updatedString.length == 0 {
            return true
        }
        if updatedString.length > 5 {
            if Double(realString) != 100 || updatedString.length > 6{
                return false
            }
        }
        guard let percent = Double(realString), percent <= 100, percent >= 0 else {
            return false
        }
        return true
    }
}
