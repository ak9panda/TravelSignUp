//
//  ViewController.swift
//  TravelSignUp
//
//  Created by Aung Kyaw Phyo on 7/25/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()

        self.navigationController?.navigationBar.standardAppearance = appearance
    }

    @IBAction func onTouchCreateNewAccountBtn(_ sender: Any) {
        let createAccVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateNewAccountViewController") as! CreateNewAccountViewController
        self.navigationController?.pushViewController(createAccVC, animated: true)
    }
}

