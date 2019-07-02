//
//  ExchangeViewController.swift
//  baluchon
//
//  Created by Jordan MOREAU on 14/06/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

// MARK: ExchangeViewController

final class ExchangeViewController: UIViewController {
    
    // MARK: Outlet connections
    
    @IBOutlet weak var baseTextField: UITextField!
    @IBOutlet weak var baseButton: UIButton!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var exchangeLabel: UILabel!
    
    @IBAction func tapBaseButton() {
        presentAlert(message: "Malheureusement vous ne pouvez pas changer la devise de base dans cette version")
    }
    
    // Collection to set border corners
    @IBOutlet var views: [UIView]!
    
    
    private let symbolsPickerView = UIPickerView()
    private let exchangeService = ExchangeService()
    
    private var pickerViewSymbols = [String]()
    private var rates = [String:Double]()
    private var currency = ""
    private var base: Double = 0
    private var rate: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBorders()
        initializeRates()
        initializeSymbolsPickerView()
    }
    
    private func addPickerView(){
        symbolsPickerView.dataSource = self
        symbolsPickerView.delegate = self
        currencyTextField.inputView = symbolsPickerView
    }
    
    private func initializeSymbolsPickerView(){
        addPickerView()
        exchangeService.getSymbols { (success, symbols) in
            if success, let symbols = symbols{
                for (key, value) in symbols {
                    self.pickerViewSymbols.append("\(key) \(value)")
                }
                let ordered = self.pickerViewSymbols.sorted(by: <)
                self.pickerViewSymbols = ordered
            }else{
                self.presentAlert(message: "Le téléchargement de la liste des devises a échoué")
            }
        }
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
    
    private func initializeRates(){
        exchangeService.getExchange{ (success, exchange) in
            if success, let exchange = exchange{
                self.rates = exchange
                print(exchange)
                self.updateRates()
            }else{
                self.presentAlert(message: "Le téléchargement des taux de change a échoué")
            }
        }
    }
    
    private func updateRates(){
        guard let currency = currencyTextField.text, let rate = rates[currency] else{
            presentAlert(message: "La mise à jour des taux de change a échoué")
            return
        }
        self.currency = currency
        self.rate = rate
    }
}

// MARK: - Keyboard and PickerView dismisss
extension ExchangeViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        baseTextField.resignFirstResponder()
        if currencyTextField.resignFirstResponder(){
            let currencyIndex = symbolsPickerView.selectedRow(inComponent: 0)
            let completeCurrency = pickerViewSymbols[currencyIndex]
            if let currency = completeCurrency.components(separatedBy: " ").first{
                self.currency = currency
                currencyTextField.text = currency
            }
        }
    }
}

// MARK: Calculate
extension ExchangeViewController{
    @IBAction func tappedConvertButton() {
        guard baseTextField.text != nil else{
            self.presentAlert(message: "Entrez une expresion correcte")
            return
        }
        exchangeLabel.text = String(calculate())
    }
    private func calculate() -> Double{
        guard let baseText = baseTextField.text, let rate = rates[currency], let base = Double(baseText)
            else{
                presentAlert(message: "Une erreur inattendue s'est produite")
                return 0
        }
        return rate * base
    }
}

// MARK: PickerView
extension ExchangeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewSymbols.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewSymbols[row]
    }
}
