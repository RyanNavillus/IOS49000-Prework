//
//  SettingsViewController.swift
//  tippy
//
//  Created by Ryan Sullivan on 1/9/19.
//  Copyright © 2019 Ryan Sullivan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipOptionsBackgroundView: UIView!
    @IBOutlet weak var tipOptionsLabel: UILabel!
    @IBOutlet weak var tipOptionsButton: UIButton!
    
    @IBOutlet weak var tipLineView: UIView!
    @IBOutlet weak var defaultTipBackgroundView: UIView!
    @IBOutlet weak var defaultTipLabel: UILabel!
    @IBOutlet weak var defaultTipSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var currencyBackgroundView: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyButton: UIButton!
    
    @IBOutlet weak var themeBackgroundView: UIView!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadDefaultTip()
        loadTheme()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTipOptions()
        loadDefaultTip()

    }
    
    func loadTipOptions() {
        
        let defaults = UserDefaults.standard
        let option1 = defaults.string(forKey: "option1")
        let option2 = defaults.string(forKey: "option2")
        let option3 = defaults.string(forKey: "option3")
        
        defaultTipSegmentedControl.setTitle(option1, forSegmentAt: 0)
        defaultTipSegmentedControl.setTitle(option2, forSegmentAt: 1)
        defaultTipSegmentedControl.setTitle(option3, forSegmentAt: 2)

    }
    
    func loadDefaultTip() {
        let defaults = UserDefaults.standard
        let defaultTip = defaults.string(forKey: "defaultTip")
        var index = 0
        while (index < defaultTipSegmentedControl.numberOfSegments && defaultTipSegmentedControl.titleForSegment(at: index) != nil) {
            guard let tip = defaultTipSegmentedControl.titleForSegment(at: index) else {
                continue
            }
            if defaultTip == tip {
                defaultTipSegmentedControl.selectedSegmentIndex = index
                break
            }
            index += 1
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
        
        navigationController?.navigationBar.backgroundColor = .darkPrimaryBackgroundColor
        navigationController?.navigationBar.tintColor = .darkTintColor
        navigationController?.navigationBar.barStyle = .blackOpaque
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkTextColor]

        
        tipOptionsBackgroundView.backgroundColor = .darkPrimaryBackgroundColor
        tipOptionsLabel.textColor = .darkTextColor
        tipOptionsButton.setImage(tipOptionsButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        tipOptionsButton.tintColor = .darkTintColor
        
        defaultTipBackgroundView.backgroundColor = .darkPrimaryBackgroundColor
        tipLineView.backgroundColor = .darkSecondaryBackgroundColor
        defaultTipSegmentedControl.tintColor = .darkTintColor
        defaultTipSegmentedControl.backgroundColor = .darkPrimaryBackgroundColor
        defaultTipLabel.textColor = .darkTextColor
        
        currencyBackgroundView.backgroundColor = .darkPrimaryBackgroundColor
        currencyLabel.textColor = .darkTextColor
        currencyButton.setImage(currencyButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        currencyButton.tintColor = .darkTintColor
        
        themeBackgroundView.backgroundColor = .darkPrimaryBackgroundColor
        themeLabel.textColor = .darkTextColor
        themeSegmentedControl.tintColor = .darkTintColor
        themeSegmentedControl.backgroundColor = .darkPrimaryBackgroundColor
        themeSegmentedControl.selectedSegmentIndex = 1
        
    }
    
    func disableDarkMode() {
        view.backgroundColor = .lightSecondaryBackgroundColor
        
        navigationController?.navigationBar.backgroundColor = .lightPrimaryBackgroundColor
        navigationController?.navigationBar.tintColor = .lightTintColor
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightTextColor]

        
        tipOptionsBackgroundView.backgroundColor = .lightPrimaryBackgroundColor
        tipOptionsLabel.textColor = .lightTextColor
        tipOptionsButton.setImage(tipOptionsButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        tipOptionsButton.tintColor = .lightTintColor
        
        defaultTipBackgroundView.backgroundColor = .lightPrimaryBackgroundColor
        tipLineView.backgroundColor = .lightSecondaryBackgroundColor
        defaultTipSegmentedControl.tintColor = .lightTintColor
        defaultTipSegmentedControl.backgroundColor = .lightPrimaryBackgroundColor
        defaultTipLabel.textColor = .lightTextColor
        
        currencyBackgroundView.backgroundColor = .lightPrimaryBackgroundColor
        currencyLabel.textColor = .lightTextColor
        currencyButton.setImage(currencyButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        currencyButton.tintColor = .lightTintColor
        
        themeBackgroundView.backgroundColor = .lightPrimaryBackgroundColor
        themeLabel.textColor = .lightTextColor
        themeSegmentedControl.tintColor = .lightTintColor
        themeSegmentedControl.backgroundColor = .lightPrimaryBackgroundColor
        themeSegmentedControl.selectedSegmentIndex = 0
    }
    
    @IBAction func defaultTipChanged(_ sender: Any) {
        if let segmentedControl = sender as? UISegmentedControl {
            let defaults = UserDefaults.standard
            defaults.set(segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex), forKey: "defaultTip")
            defaults.synchronize()
        }

    }
    
    @IBAction func themeChanged(_ sender: Any) {
        if let segmentedControl = sender as? UISegmentedControl {
            let defaults = UserDefaults.standard
            defaults.set(segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex), forKey: "theme")
            defaults.synchronize()
            loadTheme()
        }
    }
}
