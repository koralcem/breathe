import UIKit

class BreathBarViewController: UIViewController {
	@IBOutlet weak var breathBar: UIView!
	@IBOutlet weak var borderBar: UIView!
	
	let breathBarPadding: CGFloat = 20
	
	// There seems to be no IB attributes for these
	let borderBarWidth: CGFloat = 10
	let borderBarColor = UIColor.blueColor().CGColor
	let barCornerRadius: CGFloat = 5
	
	var fullBreathBarFrame: CGRect = CGRectZero
	var emptyBreathBarFrame: CGRect = CGRectZero

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
		
		let breathBarWidth = borderBar.frame.size.width - 2 * breathBarPadding
		
		fullBreathBarFrame = CGRectMake(breathBarPadding,
										breathBarPadding,
										breathBarWidth,
										borderBar.frame.size.height - 2 * breathBarPadding)
		
		emptyBreathBarFrame = CGRectMake(breathBarPadding,
										 borderBar.frame.size.height - breathBarPadding,
										 breathBarWidth,
										 0)
		
		startBreathingAnimation()
	}
	
	func startBreathingAnimation() {
		stopBreathingAnimation()	// Breath bar begins from the bottom
		expand(0)					// Initial expansion starts immediately
	}
	
	func stopBreathingAnimation() {
		breathBar.layer.removeAllAnimations()
		breathBar.frame = emptyBreathBarFrame
	}
	
	func collapse(delay: NSTimeInterval) {
		UIView.animateWithDuration(userDefaultForTime(BreatheOutTimeKey), delay: delay, options: .CurveLinear, animations: {
			self.breathBar.frame = self.emptyBreathBarFrame
			
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
			self.breathBar.frame = self.fullBreathBarFrame
			
			}, completion: { finished in
				if (finished) {
					self.collapse(self.userDefaultForTime(PauseTimeAfterBreathInKey))
				} else {
					self.stopBreathingAnimation()
				}
		})
	}
	
	func debugCGRect(rect: CGRect, name: String) {
		print("\(name)\n\tOrigin: x=\(rect.origin.x), y=\(rect.origin.y)\n\tSize: width=\(rect.size.width), height=\(rect.size.height)")
	}
	
	func printDebugInfo() {
		//debugCGRect(borderBar.frame, name: "Border")
		debugCGRect(breathBar.frame, name: "Breath")
		//debugCGRect(emptyBreathBarFrame, name: "Empty frame")
		//debugCGRect(fullBreathBarFrame, name: "Full frame")
	}
	
	func userDefaultForTime(userDefaultsKey: String) -> Double {
		return Double(NSUserDefaults.standardUserDefaults().integerForKey(userDefaultsKey))
	}
}

