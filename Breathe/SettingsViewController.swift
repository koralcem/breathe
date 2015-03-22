import UIKit

let BreatheInTimeKey = "Breathe in time"
let PauseTimeAfterBreathInKey = "Pause time after breath in"
let BreatheOutTimeKey = "Breathe out time"
let PauseTimeAfterBreathOutKey = "Pause time after breath out"

class SettingsViewController: UIViewController {

	@IBOutlet weak var breatheInTimeLabel: UILabel!
	@IBOutlet weak var pauseAfterBreathInTimeLabel: UILabel!
	@IBOutlet weak var breatheOutTimeLabel: UILabel!
	@IBOutlet weak var pauseAfterBreathOutTimeLabel: UILabel!
	
	@IBOutlet weak var breatheInTimeSlider: UISlider!
	@IBOutlet weak var pauseAfterBreatheInTimeSlider: UISlider!
	@IBOutlet weak var breatheOutTimeSlider: UISlider!
	@IBOutlet weak var pauseAfterBreathOutTimeSlider: UISlider!
	
	var sliders: [UISlider] = []
	var labels: [UILabel] = []
	let userDefaultsKeys = [BreatheInTimeKey, PauseTimeAfterBreathInKey, BreatheOutTimeKey, PauseTimeAfterBreathOutKey]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		sliders = [breatheInTimeSlider, pauseAfterBreatheInTimeSlider, breatheOutTimeSlider, pauseAfterBreathOutTimeSlider]
		labels = [breatheInTimeLabel, pauseAfterBreathInTimeLabel, breatheOutTimeLabel, pauseAfterBreathOutTimeLabel]
		
		refreshInterface()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
	}
	
	@IBAction func sliderValueChanged(sender: UISlider) {
		let newValue = Int(round(sender.value))
		let index = find(sliders, sender)
		labels[index!].text = "\(newValue) seconds"
		NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey:userDefaultsKeys[index!])
	}
	
	func refreshInterface() {
		for (index, defaultKey) in enumerate(userDefaultsKeys) {
			let value = NSUserDefaults.standardUserDefaults().integerForKey(defaultKey)
			labels[index].text = "\(value) seconds"
			sliders[index].value = Float(value)
		}
	}
}
