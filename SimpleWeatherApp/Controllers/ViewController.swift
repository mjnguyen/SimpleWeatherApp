//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by Michael Nguyen on 5/16/22.
//

import UIKit

class ViewController: UIViewController {
    let messageField = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let textField = UITextField()


        textField.placeholder = "Enter a City Name"
        textField.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(textField)

        let searchButton = UIButton()
        searchButton.titleLabel?.textColor = .white
        searchButton.setTitle("Weather Report", for: .normal)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        let action = UIAction(title: "LOOKUP", image: nil, identifier: .none, attributes: [.destructive], state: .on) { action in
            if let cityName = textField.text, cityName.count > 0 {
                WeatherService.shared.currentWeather(city: cityName) { success, conditions, error in
                    // do something with the conditions
                    if let conditions = conditions, success {
                        DispatchQueue.main.async {
                            self.messageField.text = "\"\(conditions.name)\" is currently \(conditions.main.temp) degrees F"
                            self.messageField.textColor = .black
                            print(conditions)
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.messageField.text = "Failed to get current weather conditions for \"\(cityName)\""
                            self.messageField.textColor = .red
                        }
                    }
                }
            }
        }
        searchButton.addAction(action, for: .touchUpInside)
        searchButton.backgroundColor = .blue
        searchButton.layer.cornerRadius = 10
        searchButton.layer.masksToBounds = true
        self.view.addSubview(searchButton)

        messageField.backgroundColor = .cyan
        messageField.numberOfLines = 0
        messageField.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(messageField)

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            searchButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 20),
            messageField.leftAnchor.constraint(equalTo: textField.leftAnchor),
            messageField.rightAnchor.constraint(equalTo: searchButton.rightAnchor),
            messageField.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20)
        ])
    }

}

