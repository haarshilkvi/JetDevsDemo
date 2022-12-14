//
//  LoginViewController.swift
//  JetDevsHomeWork
//
//  Created by Harshil on 13/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController,ControllerType {
   
    
    typealias ViewModelType = LoginViewModel
    private var viewModel: ViewModelType!
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var lblErrorEmail: UILabel!
    @IBOutlet var lblErrorPassword: UILabel!
    var emailRelay = BehaviorRelay<String?>(value: "")
    var passwordRelay = BehaviorRelay<String?>(value: "")
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configure(with: viewModel)
    }
    func setupBindings() {
        txtEmail.rx.text.bind(to: emailRelay).disposed(by: disposeBag)
        emailRelay.map { ($0 ?? "").validateEmail() }.bind { _ in
            self.loginBtnValidation()
        }.disposed(by: disposeBag)
        txtPassword.rx.text.bind(to: passwordRelay).disposed(by: disposeBag)
        passwordRelay.map { ($0 ?? "").validatePassword() }.bind { _ in
            self.loginBtnValidation()
        }.disposed(by: disposeBag)
    }
    func loginBtnValidation() {
        (txtEmail.text ?? "") == "" ? (lblErrorEmail.isHidden = true ):  (lblErrorEmail.isHidden = (txtEmail.text ?? "").validateEmail())
        (txtPassword.text ?? "") == "" ? (lblErrorPassword.isHidden = true ):  (lblErrorPassword.isHidden = (txtPassword.text ?? "").validatePassword())
        if (txtEmail.text ?? "").validateEmail() == true
            && (txtPassword.text ?? "").validatePassword() == true {
         
            btnLogin.backgroundColor = UIColor(named: "btnPrimary")
        } else {
    
            btnLogin.backgroundColor = UIColor(named: "btnDisable")
        }
        
   
    }
    func configure(with viewModel: LoginViewModel) {
        txtEmail.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.email)
            .disposed(by: disposeBag)
        
        txtPassword.rx.text.asObservable()
            .ignoreNil()
            .subscribe(viewModel.input.password)
            .disposed(by: disposeBag)
    
        
        btnLogin.rx.tap.asObservable()
            .subscribe(viewModel.input.signInDidTap)
            .disposed(by: disposeBag)
        btnLogin.rx.tap.asObservable().subscribe { event in
            if #available(iOS 13.0, *) {
                ImShSwiftLoader.shared.show()
            } 
        }
        viewModel.output.errorsObservable
            .subscribe(onNext: { [unowned self] (error) in
                print("error \(error)")
            })
            .disposed(by: disposeBag)
        
        viewModel.output.loginResultObservable
            .subscribe(onNext: { [unowned self] (user) in
                if #available(iOS 13.0, *) {
                    ImShSwiftLoader.shared.hide()
                }
                if user.userId != 0 {
                    let vcAccount = AccountViewController(nibName: "AccountViewController", bundle: nil)
                    self.navigationController?.pushViewController(vcAccount, animated: true)
                    vcAccount.user = user
                    print("User successfully signed in")
                }else {
                    if #available(iOS 13.0, *) {
                        ImShSwiftLoader.shared.hide()
                    }
                    Toast.show(message: "User dose not exist", controller: self)
                    print("User dose not exist")
                }
            })
            .disposed(by: disposeBag)
         
    }
    
    static func create(with viewModel: LoginViewModel) -> UIViewController {
        let vcLogin = LoginViewController(nibName: "LoginViewController", bundle: nil)
        vcLogin.viewModel = viewModel
        return vcLogin
    }

}

