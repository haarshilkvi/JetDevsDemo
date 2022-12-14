//
//  AccountViewController.swift
//  JetDevsHomeWork
//
//  Created by Gary.yao on 2021/10/29.
//

import UIKit
import Kingfisher

class AccountViewController: UIViewController {

	@IBOutlet weak var nonLoginView: UIView!
	@IBOutlet weak var loginView: UIView!
	@IBOutlet weak var daysLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var headImageView: UIImageView!
    var user:User?
	override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        if user != nil {
            nonLoginView.isHidden = true
            loginView.isHidden = false
            nameLabel.text = user?.userName
            let days = user?.createdAt?.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")?.interval(ofComponent: .day, fromDate: Date())
            daysLabel.text = "Created \(days ?? 0) days ago"
            user?.createdAt?.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
            
        }else {
            nonLoginView.isHidden = false
            loginView.isHidden = true
        }
		
    }
	
	@IBAction func loginButtonTap(_ sender: UIButton) {
        let loginService = LoginService()
        let loginControllerViewModel = LoginViewModel(loginService)
       
        let vcLogin =  LoginViewController.create(with: loginControllerViewModel)
        let navToLogin = UINavigationController(rootViewController: vcLogin)
        navToLogin.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navToLogin, animated: true)
        
	}
	
}
