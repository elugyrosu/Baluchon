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
    @IBOutlet weak var originalLanguageTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var translationLanguageTextField: UITextField!
    
    @IBOutlet var views: [UIView]!
    
    let translationLanguagePickerView = UIPickerView()
    let translationService = TranslationService()

    var pickerViewTranslationLanguages = [String]()
    var originalLanguage = "FR"
    var translationLanguageSymbol = "EN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBorders()
        initializeLanguagesPickerView()
        // Do any additional setup after loading the view.
    }

    @IBAction func originalLanguageButtonTapped() {
        presentAlert(message: "Sorry but you cannot choose an other original language in this version")
    }
    private func initializeLanguagesPickerView(){
        addPickerView()
        translationService.getLanguages { (success, data) in
            if success, let data = data{
                for language in data.languages{
                    let key = language.language
                    let uppercaseKey = key.uppercased()
                    let value = language.name
                    self.pickerViewTranslationLanguages.append("\(uppercaseKey) \(value)")
                }
                let ordered = self.pickerViewTranslationLanguages.sorted(by: <)
                self.pickerViewTranslationLanguages = ordered
            }else{
                self.presentAlert(message: "The symbols download failed.")
            }
        }
    }
    private func addCircularBorder(to view: UIView, with width: CGFloat){
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.borderWidth = width
        view.layer.borderColor = #colorLiteral(red: 0.2297611833, green: 0.6683197618, blue: 0.7820833921, alpha: 1)
    }
    private func addPickerView(){
        translationLanguagePickerView.dataSource = self
        translationLanguagePickerView.delegate = self
        translationLanguageTextField.inputView = translationLanguagePickerView
    }
    private func addBorders(){
        for view in views{
            addCircularBorder(to: view, with: 2)
        }
        originalLanguageTextView.layer.cornerRadius = 10
        originalLanguageTextView.layer.borderWidth = 1
        originalLanguageTextView.layer.borderColor = #colorLiteral(red: 0.2297611833, green: 0.6683197618, blue: 0.7820833921, alpha: 1)
        
        translationTextView.layer.cornerRadius = 10
        translationTextView.layer.borderWidth = 1
        translationTextView.layer.borderColor = #colorLiteral(red: 0.2297611833, green: 0.6683197618, blue: 0.7820833921, alpha: 1)
    }
}

// MARK: - Keyboard dismisss
extension TranslateViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        originalLanguageTextView.resignFirstResponder()
        translationTextView.resignFirstResponder()
        if translationLanguageTextField.resignFirstResponder(){
            let translationLanguageIndex = translationLanguagePickerView.selectedRow(inComponent: 0)
            let completeTranslationLanguage = pickerViewTranslationLanguages[translationLanguageIndex]
            if let translationLanguage = completeTranslationLanguage.components(separatedBy: " ").first{
                self.translationLanguageSymbol = translationLanguage
                translationLanguageTextField.text = translationLanguageSymbol
            }
        }
    }
}
// MARK: PickerView

extension TranslateViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewTranslationLanguages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewTranslationLanguages[row]
    }
}
// MARK: Alerts

extension TranslateViewController {
    private func presentAlert(message: String){
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

extension TranslateViewController: DisplayAlert { // use DisplayAlert protocol
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
