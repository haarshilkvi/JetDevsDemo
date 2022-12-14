//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on December 14, 2022
//
import Foundation
import SwiftyJSON

struct BaseAPIResult {

	let result: Int?
	let errorMessage: String?
	let data: BaseData?
    
    
	init(_ json: JSON) {
		result = json["result"].intValue
		errorMessage = json["error_message"].stringValue
		data = BaseData(json["data"])
	}

}
 
