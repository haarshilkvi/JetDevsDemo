//
//  User.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on December 14, 2022
//
import Foundation
import SwiftyJSON

struct User {

	let userId: Int?
	let userName: String?
	let userProfileUrl: String?
	let createdAt: String?

	init(_ json: JSON) {
		userId = json["user_id"].intValue
		userName = json["user_name"].stringValue
		userProfileUrl = json["user_profile_url"].stringValue
		createdAt = json["created_at"].stringValue
	}

}