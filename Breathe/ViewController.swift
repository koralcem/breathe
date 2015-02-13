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

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		var displayLink = CADisplayLink.init(target:self, selector:"update:")
		displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)

		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		UIView.animateWithDuration(2.0, delay: 0, options: .CurveEaseOut, animations: {
			self.redView.frame.origin.x -= 50
			
			}, completion: { finished in
				println("Animation done")
		})
	}
	
	func update(displayLink: CADisplayLink) {
		println(displayLink.timestamp)
		println("Update called")
	}


}

