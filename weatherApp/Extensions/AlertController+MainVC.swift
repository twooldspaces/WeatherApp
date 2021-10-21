//
//  AlertController + MainVC.swift
//  weatherApp
//
//  Created by Artem on 02.10.2021.
//

import UIKit


extension MainViewController {
    
    func presentSearchAlert (title: String?, message: String?, style: UIAlertController.Style, completionHendler: @escaping (String) -> Void) {
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        // добавляем textfield в alert
        alert.addTextField { (textField) in
            textField.placeholder = "City"
        }
        // кнопка search
        let search = UIAlertAction(title: "Search", style: .default) { action in
            
            let textField = alert.textFields?.first
            // создаем cityname из text field
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                
                // разделяем и соединям слова 
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHendler(city)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(search)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    
    
    
    
