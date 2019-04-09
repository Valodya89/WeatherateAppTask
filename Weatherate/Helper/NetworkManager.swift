//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit
import Alamofire

 let APPKEY = "ea82c5e4ba0823d2fde5b2fe23397430"
 let APP_BASE_URL = "http://api.openweathermap.org/data/2.5/"
 let IMAGE_BASE_URL = "https://openweathermap.org/img/w/"

class NetworkManager: NSObject {

	static let sharedInstance = NetworkManager()

	override init() {

	}

	func GETRequest(url: String, parameters: Dictionary<String, Any>? , success : @escaping (( _ response: Any?,_ statusCode: Int)->(Void)), failure: @escaping ((_ errorCode: Int)->(Void))) {

		let headers = ["Accept": "application/json"]

		Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in

			if response.result.isSuccess {
				success(response.result.value,(response.response?.statusCode)!)
			} else if response.result.isFailure {
				failure(402)
			}
		}

	}
}
