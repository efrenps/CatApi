//
//  HomeViewController.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var continueButton: FilledButton!
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.delegate = self
        continueButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    // MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") + string
        text.count > 1 ? (continueButton.isEnabled = true) : (continueButton.isEnabled = false)
        return true
    }

    @IBAction func onContinue(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VoteViewController") as! VoteViewController

        vc.currentName = nameField.text ?? "Anonimo"
        self.navigationController?.show(vc, sender: true)
    }
}
