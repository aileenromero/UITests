//
//  ViewController.swift
//  uitests
//
//  Created by Aileen Romero on 6/8/21.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: SignInViewModel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewModel()
        bindToViewModel()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Instance
    
    private func configureViewModel() {
        self.viewModel = SignInViewModel(api: AuthServices.shared)
    }
    
    private func bindToViewModel() {
        viewModel.didError = { [weak self] error in
            print("test123: \(error.localizedDescription.description)")
            self?.presentDismissableAlertController(title: "Invalid", message: "The username or password you entered is incorrect.")
        }
        viewModel.didSignIn = { [weak self] viewModel in
           guard viewModel.isLoading else {
               self?.activityIndicatorView.stopAnimating()
               return
           }
           self?.activityIndicatorView.isHidden = false
           self?.activityIndicatorView.startAnimating()
        }
        
        viewModel.didSuccessSignIn = { [weak self] in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
            self?.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        print("test")
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard !usernameTextField.text!.isEmpty && !passwordTextField.text!.isEmpty else {
            presentDismissableAlertController(title: "Invalid", message: "Username/Password should not be empty")
            return
        }
        viewModel.signIn(username: usernameTextField.text, password: passwordTextField.text)
    }
    
}
