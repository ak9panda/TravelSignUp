//
//  CreateNewAccountViewController.swift
//  TravelSignUp
//
//  Created by Aung Kyaw Phyo on 7/25/23.
//

import UIKit

final class CreateNewAccountViewController: UIViewController {
    
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var tfFirstName: BottomBorderTextField!
    @IBOutlet weak var tfLastName: BottomBorderTextField!
    @IBOutlet weak var tfEmailAddress: BottomBorderTextField!
    @IBOutlet weak var tfDateOfBirth: BottomBorderTextField!
    @IBOutlet weak var tfNationality: BottomBorderTextField!
    @IBOutlet weak var tfResidence: BottomBorderTextField!
    @IBOutlet weak var tfMobileNo: BottomBorderTextField!
    @IBOutlet weak var genderSegmenControl: UISegmentedControl!
    
    @IBOutlet weak var lblFirstNameError: UILabel!
    @IBOutlet weak var lblLastNameError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lbldobError: UILabel!
    @IBOutlet weak var lblNationalityError: UILabel!
    @IBOutlet weak var lblResidenceError: UILabel!
    @IBOutlet weak var lblMobileNoError: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // set keyboard notification
        setKeyboardNoti()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - HELPER FUNCTIONS
extension CreateNewAccountViewController {
    fileprivate func setupView() {
        
        self.setupToHideKeyboardOnTapOnView()
        tfFirstName.delegate = self
        tfLastName.delegate = self
        tfEmailAddress.delegate = self
        tfDateOfBirth.delegate = self
        tfNationality.delegate = self
        tfResidence.delegate = self
        tfMobileNo.delegate = self
        tfDateOfBirth.addRighView(imgName: "dob")
        
        genderSegmenControl.layer.cornerRadius = (genderSegmenControl.frame.height / 2)
        genderSegmenControl.layer.masksToBounds = true
        genderSegmenControl.clipsToBounds = true
    }
    
    fileprivate func setKeyboardNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // keyborad functions
    @objc func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let rect: CGRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
        let kbSize = rect.size

        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        backgroundScrollView.contentInset = insets
        backgroundScrollView.scrollIndicatorInsets = insets

        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your application might not need or want this behavior.
        var aRect = self.view.frame;
        aRect.size.height -= kbSize.height;

        let activeField: UITextField? = [tfFirstName, tfLastName, tfEmailAddress, tfDateOfBirth, tfNationality, tfResidence, tfMobileNo].first { $0.isFirstResponder }
        if let activeField = activeField {
            if !aRect.contains(activeField.frame.origin) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y-kbSize.height)
                backgroundScrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        backgroundScrollView.contentInset = UIEdgeInsets.zero
        backgroundScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}


extension CreateNewAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfFirstName:
            tfLastName.becomeFirstResponder()
        case tfLastName:
            tfEmailAddress.becomeFirstResponder()
        case tfEmailAddress:
            tfDateOfBirth.becomeFirstResponder()
        case tfDateOfBirth:
            tfNationality.becomeFirstResponder()
        case tfNationality:
            tfResidence.becomeFirstResponder()
        case tfResidence:
            tfMobileNo.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: String = currentString.replacingCharacters(in: range, with: string) as String
        switch textField {
        case tfFirstName:
            lblFirstNameError.isHidden = (3 < newString.count && newString.count < 15)
        case tfLastName:
            lblFirstNameError.isHidden = (3 < newString.count && newString.count < 15)
        case tfEmailAddress:
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let status = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: newString)
            lblEmailError.isHidden = status
        case tfDateOfBirth:
            let regex = #"^(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[0-2])/\d{4}$"#
            let status = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: newString)
            lbldobError.isHidden = status
        case tfNationality:
            lblNationalityError.isHidden = (3 < newString.count && newString.count < 15)
        case tfResidence:
            lblResidenceError.isHidden = (3 < newString.count && newString.count < 15)
        case tfMobileNo:
            let regex = #"^\+?[1-9]\d{1,14}$"#
            let status = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: newString)
            lbldobError.isHidden = status
        default: break
        }
        return true
    }
}
