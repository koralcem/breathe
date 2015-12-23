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
		NSUserDefaults.standardUserDefaults().registerDefaults([BreatheInTimeKey:3,
																PauseTimeAfterBreathInKey:1,
																BreatheOutTimeKey: 4,
																PauseTimeAfterBreathOutKey: 1])
		
		// setup the attributes of the bars that can't be adjusted from IB
		borderBar.backgroundColor = UIColor.whiteColor()
		borderBar.layer.borderColor = borderBarColor
		borderBar.layer.borderWidth = borderBarWidth
		borderBar.layer.cornerRadius = barCornerRadius
		
		breathBar.layer.cornerRadius = barCornerRadius
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "appDidBecomeActive", name: UIApplicationDidBecomeActiveNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillResignActive", name: UIApplicationWillResignActiveNotification, object: nil)
	}
	
	func appDidBecomeActive() {
		startBreathingAnimation()
	}
	
	func appWillResignActive() {
		stopBreathingAnimation()
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		startBreathingAnimation()
	}
	
	func startBreathingAnimation() {
		if CGRectIsEmpty(originalFrame) {
			originalFrame = breathBar.frame
		}
		
		stopBreathingAnimation()	// Breath bar begins from the bottom
		expand(0)					// Initial expansion starts immediately
	}
	
	func stopBreathingAnimation() {
		breathBar.layer.removeAllAnimations()
		breathBar.frame = originalFrame
		breathBar.frame.size.height = 0
		breathBar.frame.origin.y += originalFrame.size.height
	}
	
	func collapse(delay: NSTimeInterval) {
		UIView.animateWithDuration(userDefaultForTime(BreatheOutTimeKey), delay: delay, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = 0
			self.breathBar.frame.origin.y += self.originalFrame.size.height
			
			}, completion: { finished in
				if (finished) {
					self.expand(self.userDefaultForTime(PauseTimeAfterBreathOutKey))
				} else {
					self.stopBreathingAnimation()
				}
		})
	}
	
	func expand(delay: NSTimeInterval) {
		UIView.animateWithDuration(userDefaultForTime(BreatheInTimeKey), delay: delay, options: .CurveLinear, animations: {
			self.breathBar.frame.size.height = self.originalFrame.size.height
			self.breathBar.frame.origin.y -= self.originalFrame.size.height
			
			}, completion: { finished in
				if (finished) {
					self.collapse(self.userDefaultForTime(PauseTimeAfterBreathInKey))
				} else {
					self.stopBreathingAnimation()
				}
		})
	}
	
	func breathBarDescription() -> String {
		return "\tOrigin: x=\(breathBar.frame.origin.x), y=\(breathBar.frame.origin.y)\n\tSize: width=\(breathBar.frame.size.width), height=\(breathBar.frame.size.height)"
	}
	
	func userDefaultForTime(userDefaultsKey: String) -> Double {
		return Double(NSUserDefaults.standardUserDefaults().integerForKey(userDefaultsKey))
	}
}

