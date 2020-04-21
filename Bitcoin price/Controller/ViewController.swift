//
//  ViewController.swift
//  Bitcoin price
//
//  Created by George on 21/04/2020.
//  Copyright © 2020 George. All rights reserved.
//

import UIKit

//MARK: - ViewController
class ViewController: UIViewController, UIPickerViewDataSource {
    
    @IBOutlet weak var currency: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var convertTextfield: UITextField!
    @IBOutlet weak var convertCurrency: UILabel!
    @IBOutlet weak var convertResultLabel: UILabel!
    
    var pickerData: [String] = [String]()
    
    let service = Service()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currency.delegate = self
        self.currency.dataSource = self
        service.delegate = self
        
        pickerData = [ "USD", "EUR", "RON", "GBP"]
        
        service.getPrice(currency: "USD")
        
    }
    @IBAction func textFieldChanged(_ sender: UITextField) {
        convertPrice()
    }
    func convertPrice(){
        if convertTextfield.text != ""{
            var var1 = Double(convertTextfield.text!)
            let var2 = Double(valueLabel.text!)
            var1 = var1! / var2!
            convertResultLabel.text = String(format:"%.3f",var1!)
        }else{
            convertResultLabel.text = "..."
        }
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController : UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priceLabel.text = pickerData[row]
        convertCurrency.text = pickerData[row]
        service.getPrice(currency: priceLabel.text ?? "USD")
    }
}

//MARK: - Section Heading
extension ViewController : ServiceDelegate{
    func didUpdatePrice(_ service: Service, bitcoin: Bitcoin) {
        DispatchQueue.main.async {
            self.priceLabel.text = bitcoin.currency
            self.valueLabel.text = String(format:"%.2f",bitcoin.value)
            self.convertPrice()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
