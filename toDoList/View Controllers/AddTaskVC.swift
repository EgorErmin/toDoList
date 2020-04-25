//
//  AddTaskGroupVC.swift
//  toDoList
//
//  Created by Егор Ермин on 25.04.2020.
//  Copyright © 2020 Егор Ермин. All rights reserved.
//

import UIKit
import RealmSwift

class AddTaskVC : UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var descriptionTaskView: UITextView! {
        didSet {
            descriptionTaskView.layer.cornerRadius = 11
            descriptionTaskView.layer.borderWidth = 1
            descriptionTaskView.delegate = self
        }
    }
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - Navigation and Actions
    
    @IBAction func addTask(_ sender: Any) {
        let task = Task()
        
        guard let nameField = nameTextField.text, !nameField.isEmpty else {
            nameLabel.textColor = UIColor.red
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0 ) {
                self.nameLabel.textColor = UIColor.black
            }
            return
        }
        
        guard let descriptionField = descriptionTaskView.text, !descriptionField.isEmpty else {
            descriptionLabel.textColor = UIColor.red
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                self.descriptionLabel.textColor = UIColor.black
            }
            return
        }
        task.name = nameField
        task.notes = descriptionField
        
        try! realm.write {
            realm.add(task)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func returnToMain(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK:- Extensions

extension AddTaskVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}

extension AddTaskVC : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descriptionTaskView.resignFirstResponder()
        }
        return true
    }
}
