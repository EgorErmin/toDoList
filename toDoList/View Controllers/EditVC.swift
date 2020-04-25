//
//  DetailsVC.swift
//  toDoList
//
//  Created by Егор Ермин on 25.04.2020.
//  Copyright © 2020 Егор Ермин. All rights reserved.
//

import UIKit
import RealmSwift

class EditVC : UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionField: UITextView! {
        didSet {
            descriptionField.layer.cornerRadius = 11
            descriptionField.layer.borderWidth = 1
            descriptionField.delegate = self
        }
    }
    
    let realm = try! Realm()
    private var task: Task?
    
    //MARK:- Lificycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        guard let task = task else { return }
        nameLabel.text = task.name
        descriptionField.text = task.notes
    }
    
    func setTask( _ task: Task) {
        self.task = task
    }
    
    // MARK: - Navigation and Actions
    
    @IBAction func refreshTask(_ sender: Any) {
        guard let descriptionText = descriptionField.text, !descriptionText.isEmpty else {
            nameLabel.textColor = UIColor.red
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                self.nameLabel.textColor = UIColor.black
            }
            return
        }
        try! realm.write {
            task?.setValue(descriptionText, forKey: "notes")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        guard let task = task else { return }
        try! realm.write {
            realm.delete(task)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func returnToMain(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension EditVC : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            descriptionField.resignFirstResponder()
        }
        return true
    }
}
