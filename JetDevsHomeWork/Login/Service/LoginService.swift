//
//  ServerRequest.swift
//  JetDevsHomeWork
//
//  Created by Harshil on 14/12/22.
//
import Foundation
import RxSwift

protocol LoginServiceProtocol {
    func signIn(with credentials: Credentials) -> Observable<User>
}

class LoginService: LoginServiceProtocol {
    func signIn(with credentials: Credentials) -> Observable<User> {
        return Observable.create { observer in
            
            ServerRequest.shared.loginUser(credentials: credentials) { result in
                if let user  = result.data?.user {
                    observer.onNext(user)
                }else {
                     
                    print(result.errorMessage)
                }
            
            } failure: { error in
                 
                print(error)
            }
 
            return Disposables.create()
        }
    }
}
