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
		originalHeight = redView.frame.size.height
		
		println("The height of the bar: \(originalHeight)")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		//collapse the bar to begin with
		redView.frame.origin.y += originalHeight
		redView.frame.size.height = 0

		expand()
	}
	
	func collapse() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.redView.frame.size.height = 0
			self.redView.frame.origin.y += self.originalHeight
			
			}, completion: { finished in
				println("collapse done")
				self.expand()
		})
	}
	
	func expand() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.redView.frame.size.height = self.originalHeight
			self.redView.frame.origin.y -= self.originalHeight
			
			}, completion: { finished in
				println("expand done")
				self.collapse()
		})
	}


}

