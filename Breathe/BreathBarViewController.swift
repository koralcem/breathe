import UIKit

class BreathBarViewController: UIViewController {
	@IBOutlet weak var breathBar: UIView!
	@IBOutlet weak var borderBar: UIView!
    @IBOutlet weak var breathBarTopConstraint: NSLayoutConstraint!

	let breathBarPadding: CGFloat = 20

	override func viewDidLoad() {
		super.viewDidLoad()

        UserDefaults.standard.register(defaults: [BreatheInTimeKey:4,
                                                  PauseTimeAfterBreathInKey:1,
                                                  BreatheOutTimeKey: 6,
                                                  PauseTimeAfterBreathOutKey: 1])
		
		// setup the attributes of the bars that can't be adjusted from IB
		borderBar.layer.borderColor = UIColor.blue.cgColor
		
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
	}
	
	@objc func appDidBecomeActive() {
		startBreathingAnimation()
	}
	
	@objc func appDidEnterBackground() {
		stopBreathingAnimation()
	}
	
    override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		startBreathingAnimation()
	}
	
	func startBreathingAnimation() {
		stopBreathingAnimation()	// Breath bar begins from the bottom
        breathBar.isHidden = false
        expand(afterDelay: 0)	// Initial expansion starts immediately
	}
	
	func stopBreathingAnimation() {
		breathBar.layer.removeAllAnimations()
        breathBarTopConstraint.constant = borderBar.frame.height - breathBarPadding
        view.layoutIfNeeded()
	}
	
	func collapse(afterDelay delay: TimeInterval) {
        UIView.animate(withDuration: userDefault(for: BreatheOutTimeKey), delay: delay, options: .curveLinear, animations: {
            self.breathBarTopConstraint.constant = self.borderBar.frame.height - self.breathBarPadding
            self.view.layoutIfNeeded()
			}, completion: { finished in
				if (finished) {
                    self.expand(afterDelay: self.userDefault(for: PauseTimeAfterBreathOutKey))
				} else {
					self.stopBreathingAnimation()
				}
		})
	}
	
	func expand(afterDelay delay: TimeInterval) {
        UIView.animate(withDuration: userDefault(for: BreatheInTimeKey), delay: delay, options: .curveLinear, animations: {
            self.breathBarTopConstraint.constant = self.breathBarPadding
            self.view.layoutIfNeeded()
			}, completion: { finished in
				if (finished) {
                    self.collapse(afterDelay: self.userDefault(for: PauseTimeAfterBreathInKey))
				} else {
					self.stopBreathingAnimation()
				}
		})
	}
	
	func userDefault(for key: String) -> Double {
        return Double(UserDefaults.standard.integer(forKey: key))
	}
}

