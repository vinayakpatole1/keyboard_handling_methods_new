//
//  ViewController.swift
//  keyboard_handling_methods
//
//  Created by Apple on 12/07/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var usernametf: UITextField!
    @IBOutlet weak var passowrdtf: UITextField!
    @IBOutlet weak var forgetpasstf: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        usernametf.delegate = self
        passowrdtf.delegate = self
        forgetpasstf.delegate = self 
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addobsevers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObsevers()
    }
    
    @objc func didTapView(gesture : UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    func addobsevers()
    {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { notification in
            self.keyboardWillShow(notification : notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { notification in
            self.keyboardWillHide(notification : notification)
        }
        
    }
    
    func keyboardWillShow(notification : Notification)
    {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue?)??.cgRectValue else{
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollview.contentInset = contentInset
    }
    
    func keyboardWillHide(notification : Notification)
    {
        scrollview.contentInset = UIEdgeInsets.zero
    }
    
    func removeObsevers()
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Hide Keyboard When User touches Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Functions
    
    // When user Pressed Retrun Key On keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

