//
//  LoginManager.swift
//  Swift Off
//
//  Created by Ashkan Kashani on 2/17/16.
//  Copyright © 2016 Primer. All rights reserved.
//

import Foundation
import Firebase

class LoginManager: NSObject, PMRExperienceDelegate  {
    let fireBaseRef: Firebase

    override init() {
        self.fireBaseRef = Firebase(url: FIREBASE_BASE_URL)
    }

    // LoginManager can be used as singleton for the whole app
    class var sharedInstance: LoginManager {
        struct Singleton {
            static let instance = LoginManager()
        }
        return Singleton.instance
    }

    func logoutUser() {
        // Log user out of Primer and show the Primer welcome screens again for user to signup or login
        Primer.logOutUser()
        Primer.presentExperience()

        self.fireBaseRef.unauth();
    }

    func signUpWithInputsPrimer(inputs: [String : AnyObject]!, completionBlock: PMRUserValidationBlock!, signupComplete: Bool) {
        let result = PMRValidationResult()

        if !signupComplete {
            result.invalidateWithErrorMessage("There was an issue signing up.")
        }
        
        completionBlock(result, inputs["email"] as? String)
    }

    func loginWithInputsPrimer(inputs: [String : AnyObject]!, completionBlock: PMRUserValidationBlock!, loginComplete: Bool) {
        let result = PMRValidationResult()
        
        if loginComplete {
            Primer.logInUser()
        } else {
            result.invalidateWithErrorMessage("There was an issue logging in.")
        }
        
        completionBlock(result, inputs["email"] as? String)
    }

    func recoverWithInputsPrimer(inputs: [String : AnyObject]!, completionBlock: PMRValidationBlock!, recoverComplete: Bool) {
        let result = PMRValidationResult()
        
        if !recoverComplete {
            result.invalidateWithErrorMessage("There was an issue with recovering your password.")
        }
        
        completionBlock(result)
    }

    // Primer screens will call this method when a user signs up.
    func signUpWithFields(fields: [String : AnyObject], completion: PMRUserValidationBlock) {
        let email = fields["email"] as? String
        let password = fields["password"] as? String
        
        // Sign up with Firebase
        self.fireBaseRef.createUser(email, password: password,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the firebase account
                    self.signUpWithInputsPrimer(fields, completionBlock: completion, signupComplete: false)
                } else {
                    // We are now logged in
                    self.signUpWithInputsPrimer(fields, completionBlock: completion, signupComplete: true)
                }
        })
    }

    // Primer screens will call this method when a user logs in with email and password.
    func logInWithFields(fields: [String : AnyObject], completion: PMRUserValidationBlock) {
        let email = fields["email"] as? String
        let password = fields["password"] as? String
        
        self.fireBaseRef.authUser(email, password: password,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                    self.loginWithInputsPrimer(fields, completionBlock: completion, loginComplete: false)
                } else {
                    // We are now logged in
                    self.loginWithInputsPrimer(fields, completionBlock: completion, loginComplete: true)
                }
        })
    }


    // Primer password recovery screen will call this method when a user requests a password reset
    func recoverPasswordWithFields(fields: [String : AnyObject], completion: PMRValidationBlock) {
        let email = fields["email"] as? String

        self.fireBaseRef.resetPasswordForUser(email, withCompletionBlock: { error in
            if error != nil {
                self.recoverWithInputsPrimer(fields, completionBlock: completion, recoverComplete: false)
            } else {
                self.recoverWithInputsPrimer(fields, completionBlock: completion, recoverComplete: true)
            }
        })
    }}
