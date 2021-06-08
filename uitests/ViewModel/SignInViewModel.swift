//
//  SignInViewModel.swift
//  uitests
//
//  Created by Aileen Romero on 6/8/21.
//

import Foundation

class SignInViewModel {
    
    //MARK: - Private
    
    private let api: AuthServices
    
    
    //MARK: - Properties
    
    private(set) var isLoading: Bool = false {
        didSet { self.didSignIn?(self) }
    }
    
    var userId: Int?
    
    
    //MARK: - Lifeycle
    
    init(api: AuthServices) {
        self.api = api
    }
    
    
    //MARK: - Events
    
    var didSignIn: ((SignInViewModel) -> Void)?
    var didError: ((Error) -> Void)?
    var didSuccessSignIn: (() -> Void)?
    
    
    //MARK: - Actions
    
    func signIn(username: String?, password: String?) {
        self.isLoading = true
        self.api.login(username: username, password: password) { [weak self] (user, error) in
            guard let strongSelf = self else {
                self?.didError?(error!)
                return
            }
            strongSelf.isLoading = false
            
            guard error == nil else {
                self?.didError?(error!)
                return
            }
            
            guard let user = user else {
                let error = APIError.responseStatusError(status: "0001", message: "Error serializing response from server.")
                strongSelf.didError?(error)
                return
            }
            UserPreferences.saveUser(user)
            self?.didSuccessSignIn?()
        }
    }
    
}

