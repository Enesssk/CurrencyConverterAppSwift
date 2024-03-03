//
//  ViewController.swift
//  CurrencyConverterAppSwift
//
//  Created by Enes Kala on 3.03.2024.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    @IBOutlet weak var USDText: UILabel!
    @IBOutlet weak var BIFText: UILabel!
    @IBOutlet weak var EURText: UILabel!
    @IBOutlet weak var TRYText: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


    @IBAction func convertButtonClicked(_ sender: Any) {
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/CurrencyData/main/currency.json")
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
         
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Error!", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            
            }else{
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let bif = rates["BIF"] as? Double {
                                    self.BIFText.text = "BIF: \(bif)"
                                }
                                if let TRY = rates["TRY"] as? Double {
                                    self.TRYText.text = "TRY: \(TRY)"
                                }
                                if let EUR = rates["EUR"] as? Double {
                                    self.EURText.text = "EUR: \(EUR)"
                                }
                                if let USD = rates["USD"] as? Double {
                                    self.USDText.text = "USD: \(USD)"
                                }
                                
                            }
                        }
                    } catch{
                        print("Error!!!")
                    }
                }
            }
            
        }
        task.resume()
        
    }
}

