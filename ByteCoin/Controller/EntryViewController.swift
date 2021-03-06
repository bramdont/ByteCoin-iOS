//
//  EntryViewController.swift
//  ByteCoin
//
//  Created by Bramdont José García Aponte on 22/2/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exchangePressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toByteCoinView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toByteCoinView" {
            let byteCoinView = segue.destination  as! ViewController
            byteCoinView.currencyPicker = UIPickerView()
            
        }
    }
    
    
}
