//
//  ViewController.swift
//  Trivia
//
//  Created by Kousa, Yahya on 12/15/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var categories: [String] = []

    @IBOutlet var questionPicker: UIPickerView!
    @IBOutlet var categoryPicker: UIPickerView!
    
    var selectedCategory = ""
    var selectedNumberOfQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.viewControllers![1].tabBarItem.isEnabled = false
        
        questionPicker.isUserInteractionEnabled = false
        questionPicker.alpha = 0.5
        
        for i in Trivia.getQuestions().keys
        {
            categories.append(i)
        }
        
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        questionPicker.delegate = self
        questionPicker.dataSource = self

    }
    
    func numberOfComponents(in pickerView : UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView : UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == categoryPicker)
        {
            return categories.count
            
        }
        else
        {
            return 50
        }
        
    }
    func pickerView(_ pickerView : UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == categoryPicker)
        {
            return categories[row].replacingOccurrences(of: "Entertainment:", with: "")
        }
        else
        {
            return String(row + 1)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == categoryPicker)
        {
            questionPicker.isUserInteractionEnabled = true
            questionPicker.alpha = 1
            selectedCategory = categories[row]
        }
        else
        {
            tabBarController?.viewControllers![1].tabBarItem.isEnabled = true
            selectedNumberOfQuestions = row + 1
            var playTab = (self.tabBarController?.viewControllers![1])! as! PlayViewController
            playTab.selectedCategory = selectedCategory
            playTab.selectedNumberOfQuestions = selectedNumberOfQuestions
            
        }
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        selectedCategory = ""
        selectedNumberOfQuestions = 0
        categoryPicker.selectRow(0, inComponent: 0, animated: true)
        questionPicker.selectRow(0, inComponent: 0, animated: true)
        tabBarController?.viewControllers![0].tabBarItem.isEnabled = true
        
//        questionPicker.isUserInteractionEnabled = false
//        questionPicker.alpha = 0.5

    }
    
}


