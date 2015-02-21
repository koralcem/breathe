//
//  ViewController.swift
//  Breathe
//
//  Created by Cem Schemel on 2/12/15.
//  Copyright (c) 2015 Moonworks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var redView: UIView!
	
	var originalHeight: CGFloat = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		originalHeight = redView.frame.size.height
		collapse()
	}
		
	func collapse() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.redView.frame.size.height = 0
			
			}, completion: { finished in
				println("Left done")
				self.expand()
		})
	}
	
	func expand() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.redView.frame.size.height = self.originalHeight
			
			}, completion: { finished in
				println("Right done")
				self.collapse()
		})
	}


}

