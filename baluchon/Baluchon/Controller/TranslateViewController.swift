//
//  TranslateViewController.swift
//  baluchon
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var originalLanguageButtonView: UIButton!
    @IBOutlet weak var originalLanguageTextField: UITextField!
    
    @IBOutlet weak var translateButton: UIButton!
    
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var translationLanguageTextField: UITextField!
    
    
    @IBOutlet var views: [UIView]!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBorders()
        originalLanguageTextField.layer.cornerRadius = 10
        translationTextView.layer.cornerRadius = 10

        originalLanguageTextField.layer.borderWidth = 1
        translationTextView.layer.borderWidth = 1

        originalLanguageTextField.layer.borderColor = #colorLiteral(red: 0.2297611833, green: 0.6683197618, blue: 0.7820833921, alpha: 1)
        translationTextView.layer.borderColor = #colorLiteral(red: 0.2297611833, green: 0.6683197618, blue: 0.7820833921, alpha: 1)



        // Do any additional setup after loading the view.
    }
    
    private func addCircularBorder(to view: UIView, with width: CGFloat){
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.borderWidth = width
        view.layer.borderColor = #colorLiteral(red: 0.2297611833, green: 0.6683197618, blue: 0.7820833921, alpha: 1)
    }
    private func addBorders(){
        for view in views{
            addCircularBorder(to: view, with: 2)
        }
    }
}
