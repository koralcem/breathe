import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var breathBar: UIView!
	@IBOutlet weak var borderBar: UIView!
	
	var originalHeight: CGFloat = 0

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		originalHeight = breathBar.frame.size.height
		borderBar.backgroundColor = UIColor.whiteColor()
	
		
		println("The height of the bar: \(originalHeight)")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		//collapse the bar to begin with
		breathBar.frame.origin.y += originalHeight
		breathBar.frame.size.height = 0

		expand()
	}
	
	func collapse() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = 0
			self.breathBar.frame.origin.y += self.originalHeight
			
			}, completion: { finished in
				println("collapse done")
				self.expand()
		})
	}
	
	func expand() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = self.originalHeight
			self.breathBar.frame.origin.y -= self.originalHeight
			
			}, completion: { finished in
				println("expand done")
				self.collapse()
		})
	}


}

