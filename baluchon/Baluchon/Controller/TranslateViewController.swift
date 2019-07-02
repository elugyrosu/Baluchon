//
//  TranslateViewController.swift
//  baluchon
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

// MARK: TranslateViewController

final class TranslateViewController: UIViewController {
    
    // MARK: Outlet connections
    @IBOutlet weak var originalLanguageButtonView: UIButton!
    @IBOutlet weak var originalLanguageTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var translationTextView: UITextView!
    @IBOutlet weak var translationLanguageTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // Collection to set bordercorners
    @IBOutlet var views: [UIView]!
    
    private let translationLanguagePickerView = UIPickerView()
    private let translationService = TranslationService()

    private var pickerViewTranslationLanguages = [String]()
    private var translationLanguageSymbol = "EN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBorders()
        activityIndicatorView.isHidden = true
        initializeLanguagesPickerView()
        // Do any additional setup after loading the view.
    }

    @IBAction func originalLanguageButtonTapped() {
        presentAlert(message: "Malheureusement vous ne pouvez pas changer la langue d'origine dans cette version")
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
                self.presentAlert(message: "Le téléchargement des langues disponibles a échoué")
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
    
    private func toggleActivityIndicator(shown: Bool){
        activityIndicatorView.isHidden = shown
        translateButton.isHidden = !shown
    }
    
    @IBAction func tappedTranslateButton() {
        translate()
    }

    private func translate(){
        toggleActivityIndicator(shown: false)
        translationService.getTranslation(translationLanguage: translationLanguageSymbol, textToTranslate: originalLanguageTextView.text){ (success, data) in
            self.toggleActivityIndicator(shown: true)
            if success, let data = data{
                for translation in data.translations{
                    self.translationTextView.text = translation.translatedText
                }
            }else{
                self.presentAlert(message: "La traduction a échoué")
            }
        }
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


