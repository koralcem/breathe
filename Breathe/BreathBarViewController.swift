import UIKit

class BreathBarViewController: UIViewController {
	@IBOutlet weak var breathBar: UIView!
	@IBOutlet weak var borderBar: UIView!
	
	// There seems to be no IB attributes for these
	let borderBarWidth: CGFloat = 10
	let borderBarColor = UIColor.blueColor().CGColor
	let barCornerRadius: CGFloat = 5
	
	var originalFrame: CGRect = CGRectZero

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// setup the attributes of the bars that can't be adjusted from IB
		borderBar.backgroundColor = UIColor.whiteColor()
		borderBar.layer.borderColor = borderBarColor
		borderBar.layer.borderWidth = borderBarWidth
		borderBar.layer.cornerRadius = barCornerRadius
		
		breathBar.layer.cornerRadius = barCornerRadius
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		if CGRectIsEmpty(originalFrame) {
			originalFrame = breathBar.frame
		}
		
		collapseImmediately()	// Breath bar begins from the bottom
		expand(0)				// Initial expansion starts immediately
	}
	
	func collapseImmediately() {
		breathBar.layer.removeAllAnimations()
		breathBar.frame = originalFrame
		breathBar.frame.size.height = 0
		breathBar.frame.origin.y += originalFrame.size.height
	}
	
	func collapse(delay: NSTimeInterval) {
		UIView.animateWithDuration(2.0 /* breathe out time */, delay: delay, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = 0
			self.breathBar.frame.origin.y += self.originalFrame.size.height
			
			}, completion: { finished in
				if (finished) {
					self.expand(1 /* pause after breath out */)
				} else {
					self.collapseImmediately()
				}
		})
	}
	
	func expand(delay: NSTimeInterval) {
		UIView.animateWithDuration(2.0 /* breathe in time */, delay: delay, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = self.originalFrame.size.height
			self.breathBar.frame.origin.y -= self.originalFrame.size.height
			
			}, completion: { finished in
				if (finished) {
					self.collapse(1 /* pause after breath in */)
				} else {
					self.collapseImmediately()
				}
		})
	}
	
	func breathBarDescription() -> String {
		return "\tOrigin: x=\(breathBar.frame.origin.x), y=\(breathBar.frame.origin.y)\n\tSize: width=\(breathBar.frame.size.width), height=\(breathBar.frame.size.height)"
	}
	
	//TODO: have delay and expansion/collapse times respect NSUSerDefaults settings
}

