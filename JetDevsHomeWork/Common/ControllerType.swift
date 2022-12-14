//
//  ServerRequest.swift
//  JetDevsHomeWork
//
//  Created by Harshil on 14/12/22.
//

import UIKit

protocol ControllerType: class {
    associatedtype ViewModelType: ViewModelProtocol
   
    func configure(with viewModel: ViewModelType)
 
    static func create(with viewModel: ViewModelType) -> UIViewController
}
