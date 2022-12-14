//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on December 14, 2022
//
import Foundation
import SwiftyJSON

struct BaseData {

	let user: User?

	init(_ userData: JSON) {
		user = User(userData["user"])
	}

}
