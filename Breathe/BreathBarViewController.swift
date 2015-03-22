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
		println("Breath bar view loaded")
		// Do any additional setup after loading the view, typically from a nib.
		
		// setup the attributes of the bars that can't be adjusted from IB
		borderBar.backgroundColor = UIColor.whiteColor()
		borderBar.layer.borderColor = borderBarColor
		borderBar.layer.borderWidth = borderBarWidth
		borderBar.layer.cornerRadius = barCornerRadius
		
		breathBar.layer.cornerRadius = barCornerRadius
	
		println("Breath bar after load\n\(self.breathBarDescription())")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		println("Breath bar view appears")
		
		if CGRectIsEmpty(originalFrame) {
			println("capturing original frame!!!!")
			originalFrame = breathBar.frame
		}
		
		println("Before collapse:\n\(self.breathBarDescription())")
		collapseImmediately()	// Breath bar begins from the bottom
		println("After collapse:\n\(self.breathBarDescription())")
		
		
		//TODO: initial expansion should be without delay, one coming at the end of the collapse
		//function can have the delay at the bottom before it
		expand()
	}
	
	func collapseImmediately() {
		breathBar.layer.removeAllAnimations()
		breathBar.frame = originalFrame
		breathBar.frame.size.height = 0
		breathBar.frame.origin.y += originalFrame.size.height
	}
	
	func collapse() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = 0
			self.breathBar.frame.origin.y += self.originalFrame.size.height
			
			}, completion: { finished in
				if (finished) {
					println("collapse done")
					self.expand()
				} else {
					println("collapse interrupted")
					self.collapseImmediately()
				}
		})
	}
	
	func expand() {
		UIView.animateWithDuration(2.0, delay: 1.0, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = self.originalFrame.size.height
			self.breathBar.frame.origin.y -= self.originalFrame.size.height
			
			}, completion: { finished in
				if (finished) {
					println("expand done")
					self.collapse()
				} else {
					println("expand interrupted")
					self.collapseImmediately()
				}
		})
	}
	
	func breathBarDescription() -> String {
		return "\tOrigin: x=\(breathBar.frame.origin.x), y=\(breathBar.frame.origin.y)\n\tSize: width=\(breathBar.frame.size.width), height=\(breathBar.frame.size.height)"
	}
}

