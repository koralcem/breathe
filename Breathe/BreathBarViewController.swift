import UIKit

class BreathBarViewController: UIViewController {
	@IBOutlet weak var breathBar: UIView!
	@IBOutlet weak var borderBar: UIView!
	
	// There seems to be no IB attributes for these
	let borderBarWidth: CGFloat = 10
	let borderBarColor = UIColor.blueColor().CGColor
	let barCornerRadius: CGFloat = 5
	
	var originalHeight: CGFloat = 0
	var originalOrigin = CGPointZero

	override func viewDidLoad() {
		super.viewDidLoad()
		println("view loaded")
		// Do any additional setup after loading the view, typically from a nib.
		originalHeight = breathBar.frame.size.height
		originalOrigin = breathBar.frame.origin
		
		// setup the attributes of the bars that can't be adjusted from IB
		borderBar.backgroundColor = UIColor.whiteColor()
		borderBar.layer.borderColor = borderBarColor
		borderBar.layer.borderWidth = borderBarWidth
		borderBar.layer.cornerRadius = barCornerRadius
		
		breathBar.layer.cornerRadius = barCornerRadius
	
		
		println("The height of the bar: \(originalHeight)")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		//collapse the bar to begin with
		collapseImmediately()
		
		println("view appeared!")
		
		//TODO: initial expansion should be without delay, one coming at the end of the collapse
		//function can have the delay at the bottom before it
		expand()
	}
	
	func collapseImmediately() {
		breathBar.layer.removeAllAnimations()
		breathBar.frame.origin = originalOrigin
		breathBar.frame.origin.y += originalHeight
		breathBar.frame.size.height = 0
	}
	
	func collapse() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = 0
			self.breathBar.frame.origin.y += self.originalHeight
			
			}, completion: { finished in
				if (finished) {
					println("collapse done")
					self.expand()
				} else {
					self.collapseImmediately()
				}
		})
	}
	
	func expand() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = self.originalHeight
			self.breathBar.frame.origin.y -= self.originalHeight
			
			}, completion: { finished in
				if (finished) {
					println("expand done")
					self.collapse()
				} else {
					self.collapseImmediately()
				}
		})
	}
}

