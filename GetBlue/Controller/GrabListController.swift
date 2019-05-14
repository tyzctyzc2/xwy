//
//  GrabListController.swift
//  GetBlue
//
//  Created by tyzc on 2019/4/20.
//  Copyright © 2019 Steve Wang. All rights reserved.
//

import UIKit

class GrabListController: MyBaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GrabUrlHolder.getUrlCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        
        let cur = GrabUrlHolder.getIndexItem(index: indexPath.row)
        cell.textLabel!.text = cur.name
        
        return cell
    }
    
    @IBOutlet weak var backButton:UIButton!
    @IBOutlet weak var addButton:UIButton!
    
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var urlTextField:UITextField!
    
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.beautyMyButton(button: backButton)
        super.beautyMyButton(button: addButton)
        
        urlTextField.returnKeyType = UIReturnKeyType.done
        urlTextField.delegate=self
        urlTextField.clearButtonMode = .always
        
        nameTextField.returnKeyType = UIReturnKeyType.done
        nameTextField.delegate=self
        nameTextField.clearButtonMode = .always
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    @IBAction func addNewGrab(_ sender: Any) {
        let name: String = self.nameTextField.text ?? ""
        if (name.count < 2) {
            return
        }
        
        let url: String = self.urlTextField.text ?? ""
        if (url.count < 20) {
            return
        }
        
        GrabUrlHolder.addNewUrl(name: name, url: url)
        self.tableView.reloadData()
        self.nameTextField.text = ""
        self.urlTextField.text = ""
        NSLog("add done")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text ?? "")
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
