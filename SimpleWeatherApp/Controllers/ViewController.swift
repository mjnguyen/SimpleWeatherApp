//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by Michael Nguyen on 5/16/22.
//

import UIKit
import React

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let textField = UITextField()
        textField.placeholder = "Please Enter a City Name, State, Zip Code, etc"
        textField.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(textField)


        let searchButton = UIButton()
        searchButton.titleLabel?.textColor = .white
        searchButton.setTitle("Weather Report", for: .normal)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        let action = UIAction(title: "LOOKUP", image: nil, identifier: .none, attributes: [.destructive], state: .on) { action in
            WeatherService.shared.currentWeather(city: "San Jose") { success, conditions, error in
                // do something with the conditions
                if let conditions = conditions, success {
                    print("\(conditions.base.count) results.")
                }
                else {
                    print ("Error: \(error?.localizedDescription)")
                }
            }
        }
        searchButton.addAction(action, for: .touchUpInside)
        searchButton.backgroundColor = .blue
        self.view.addSubview(searchButton)

        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            textField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            searchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            searchButton.leftAnchor.constraint(equalTo: textField.leftAnchor, constant: 0),
            searchButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    override func loadView() {
        loadReactNativeView()
    }

    func loadReactNativeView() {
        let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")!

        let rootView = RCTRootView(
            bundleURL: jsCodeLocation,
            moduleName: "YourApp",
            initialProperties: nil,
            launchOptions: nil
        )
        self.view = rootView
    }


}

