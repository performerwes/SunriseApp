//
//  ViewController.swift
//  SunriseApp
//
//  Created by 遠藤 渉 on 2020/04/19.
//  Copyright © 2020 wataru.endo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var cityNameInput: UITextField!
	@IBOutlet weak var sunriseTimeLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func findSunrise(_ sender: Any) {
		let url = "http://api.openweathermap.org/data/2.5/weather?q=\(cityNameInput.text ?? "Tokyo")&appid=4e10516807a8aaabf4094f72a51ab5d2"
		getURL(url: url)
	}
	
	func getURL(url:String) {
		do{
			let apiURL = URL(string:url)!
			let data = try Data(contentsOf:apiURL)
			let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
			print(json)
			let query = json["sys"] as! [String:Any]
//			let sunrise = query["sunrise"]  as? Double ?? 0
//
//			// UNIX時間 "dateUnix" をNSDate型 "date" に変換
//			let dateUnix: TimeInterval = sunrise
//			let date = NSDate(timeIntervalSince1970: dateUnix)
//
//			// NSDate型を日時文字列に変換するためのNSDateFormatterを生成
//			let formatter = DateFormatter()
//			formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//			// NSDateFormatterを使ってNSDate型 "date" を日時文字列 "dateStr" に変換
//			let dateStr: String = formatter.string(from: date as Date)
//
//			self.sunriseTimeLabel.text = "日の出時刻：\(dateStr)"

			let sunrise = unixToDate(text: query["sunrise"] as Any)
			self.sunriseTimeLabel.text = "日の出時刻：\(sunrise ?? "")"
			
 		} catch {
			self.sunriseTimeLabel.text = "サーバに接続できません"
		}
	}
	
	func unixToDate(text: Any) -> String? {
		let unixDate = text as? Double ?? 0
		
		// UNIX時間 "dateUnix" をNSDate型 "date" に変換
		let dateUnix: TimeInterval = unixDate
		let date = NSDate(timeIntervalSince1970: dateUnix)

		// NSDate型を日時文字列に変換するためのNSDateFormatterを生成
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

		// NSDateFormatterを使ってNSDate型 "date" を日時文字列 "dateStr" に変換
		let dateStr: String = formatter.string(from: date as Date)

		return dateStr
	}
}

