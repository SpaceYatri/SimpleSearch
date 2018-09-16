//
//  ViewController.swift
//  SimpleSearch
//
//  Created by Sushant Tiwari on 10/09/18.
//  Copyright © 2018 Sushant Tiwari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		SearchRequest.getResult(for: "batman", pageNumber: 1) { (response) in
			switch response {
			case .success(let value):
				print(value.pageNumber)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

