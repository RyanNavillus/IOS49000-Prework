//
//  CurrencyViewController.swift
//  tippy
//
//  Created by Ryan Sullivan on 1/9/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    static let locales = Locale.availableIdentifiers.filter({ (identifier) -> Bool in
        if let code = Locale(identifier: identifier).currencyCode, code != "" {
            return true
        }
        return false
    })
    
    static let currencySymbols = locales.map { (identifier) -> String in
        return Locale(identifier: identifier).currencySymbol ?? ""
        } // Currency symbols
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTheme()
        let defaults = UserDefaults.standard
        let currency = defaults.string(forKey: "currency")
        for row in 0..<CurrencyViewController.currencySymbols.count {
            if currency == CurrencyViewController.currencySymbols[row] {
                currencyPicker.selectRow(row, inComponent: 0, animated: false)
            }
        }
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
        view.backgroundColor = .darkSecondaryBackgroundColor
        currencyPicker.backgroundColor = .darkPrimaryBackgroundColor
        currencyPicker.tintColor = .darkTextColor
    }
    
    func disableDarkMode() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CurrencyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyViewController.currencySymbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = UserDefaults.standard
        defaults.set(CurrencyViewController.locales[row], forKey: "locale")
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let code = Locale(identifier: CurrencyViewController.locales[row]).currencyCode ?? ""
        let attributedString = NSAttributedString(string: code + " - " + CurrencyViewController.currencySymbols[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkTextColor])
        return attributedString
    }
}
