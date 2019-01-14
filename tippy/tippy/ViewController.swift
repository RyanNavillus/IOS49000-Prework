//
//  ViewController.swift
//  tippy
//
//  Created by Ryan Sullivan on 1/8/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var percentSegmentedControl: UISegmentedControl!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var personStepper: EditableStepper!
    @IBOutlet weak var tipTextField: UITextField!
    
    
    var percent: Double = 15
    var personCount: Double = 1
    var value = 0.0 {
        didSet {
            resetValue()
        }
    }
    
    var text = "" {
        didSet {
            tipTextField.text = text
            calculateTip(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipTextField.delegate = self
        personStepper.delegate = self
        loadDefaultTip()
        let defaults = UserDefaults.standard
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tipTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTheme()
        loadTipOptions()
        resetValue()
        loadCost()
        calculateTip(self)
    }
    
    func loadTipOptions() {
        var tipsChanged = false
        
        let defaults = UserDefaults.standard
        let option1 = defaults.string(forKey: "option1")
        let option2 = defaults.string(forKey: "option2")
        let option3 = defaults.string(forKey: "option3")
        if percentSegmentedControl.titleForSegment(at: 0) != option1 ||
            percentSegmentedControl.titleForSegment(at: 1) != option2 ||
            percentSegmentedControl.titleForSegment(at: 2) != option3 {
            tipsChanged = true
        }
        
        percentSegmentedControl.setTitle(option1, forSegmentAt: 0)
        percentSegmentedControl.setTitle(option2, forSegmentAt: 1)
        percentSegmentedControl.setTitle(option3, forSegmentAt: 2)
        
        if tipsChanged {
            loadDefaultTip()
        }
    }
    
    func loadDefaultTip() {
        let defaults = UserDefaults.standard
        let defaultTip = defaults.string(forKey: "defaultTip")
        var index = 0
        while (index < percentSegmentedControl.numberOfSegments && percentSegmentedControl.titleForSegment(at: index) != nil) {
            guard let tip = percentSegmentedControl.titleForSegment(at: index) else {
                continue
            }
            if defaultTip == tip {
                percentSegmentedControl.selectedSegmentIndex = index
                break
            }
            index += 1
        }
    }
    
    func loadCost() {
        let defaults = UserDefaults.standard
        if let timestamp = defaults.object(forKey: "timestamp") as? Date {
            let date = Date()
            if Date().timeIntervalSince(timestamp).magnitude > 600 {
                value = 0
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
    }
    
    func enableDarkMode() {
        tipTextField.keyboardAppearance = .dark
        view.backgroundColor = .darkPrimaryBackgroundColor
        view.tintColor = .darkTintColor
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkTextColor]
        for view in view.subviews {
            view.backgroundColor = .darkPrimaryBackgroundColor
            view.tintColor = .darkTintColor
            if let label = view as? UILabel {
                label.textColor = .darkTextColor
            }
            if let textField = view as? UITextField {
                textField.backgroundColor = .darkSecondaryBackgroundColor
                textField.textColor = .darkTextColor
            }
            if let stepper = view as? EditableStepper {
                stepper.tintColor = .darkTintColor
                stepper.backgroundColor = .darkPrimaryBackgroundColor
                stepper.textColor = .darkTextColor
            }
            if view.frame.height == 1 {
                view.backgroundColor = .darkSecondaryBackgroundColor
            }
        }
    }
    
    func resetValue() {
        let formatter = createNumberFormatter()
        text = formatter.string(from: NSNumber(value: value)) ?? ""
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        tipTextField.placeholder = formatter.string(from: NSNumber(value: 0.0))
        if value == 0 {
            text = ""
        }
    }
    
    func createNumberFormatter() -> NumberFormatter {
        let defaults = UserDefaults.standard
        let localeIdentifier = defaults.string(forKey: "locale") ?? "US"
        let locale = Locale(identifier: localeIdentifier)
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func disableDarkMode() {
        tipTextField.keyboardAppearance = .default
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
            if let stepper = view as? EditableStepper {
                stepper.tintColor = .lightTintColor
                stepper.backgroundColor = .lightPrimaryBackgroundColor
                stepper.textColor = .lightTextColor
            }
            if view.frame.height == 1 {
                view.backgroundColor = .lightSecondaryBackgroundColor
            }
        }
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        var percentText = percentSegmentedControl.titleForSegment(at: percentSegmentedControl.selectedSegmentIndex) ?? "0%"
        percentText.removeLast()
        percent = Double(percentText) ?? 0.0
        var tipText = tipTextField.text ?? ""
        let currency = createNumberFormatter().locale.currencySymbol ?? ""
        if let range = tipText.range(of: currency) {
            tipText.removeSubrange(range)
        }
        let cost = Double(tipText) ?? 0.0
        let tip = cost + (percent * cost / 100)
        let tipPerPerson = tip / personCount
        let formatter = createNumberFormatter()
        totalLabel.text = formatter.string(from: NSNumber(value: tip))
        perPersonLabel.text = formatter.string(from: NSNumber(value: tipPerPerson))
        
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        print("settings")
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let settingsController = storyboard.instantiateViewController(withIdentifier: "Settings")
        //settingsController.modalTransitionStyle = .crossDissolve
        //settingsController.modalPresentationStyle = .formSheet
        //        let transition = CATransition()
        //        transition.duration = 0.4
        //        transition.type = CATransitionType.push
        //        transition.subtype = CATransitionSubtype.fromRight
        //        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        //        view.window!.layer.add(transition, forKey: kCATransition)
        //present(settingsController, animated: false, completion: nil)
        navigationController?.pushViewController(settingsController, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currency = createNumberFormatter().locale.currencySymbol ?? ""

        let nsstring = (textField.text ?? "") as NSString
        var updatedText = nsstring.replacingCharacters(in: range, with: string) as String
        if let range = updatedText.range(of: currency) {
            updatedText.removeSubrange(range)
        }
        if updatedText != "" {
            guard let checkDouble = Double(updatedText) else {
                return false
            }
        }
        
        if updatedText.count > 8 {
            return false
        }
        
        if textField.text != "" && range.location < currency.count {
            return false
        } else if textField.text == "" {
            text = currency
        } else if updatedText == "" {
            text = ""
            return false
        }
        
        let newText = nsstring.replacingCharacters(in: range, with: string) as String
        if textField.text == currency {
            if string == "0" {
                text = ""
                return false
            }
            text += newText
        } else {
            text = newText
        }
        return false;
    }
    
}

extension ViewController: EditableStepperDelegate {
    func valueChanged(sender: EditableStepper) {
        self.personCount = Double(sender.label.text ?? "0") ?? 0
        self.calculateTip(sender)
    }
}

