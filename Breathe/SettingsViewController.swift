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
		durationValueChanged(sender)
	}
	@IBAction func sliderTouchUpInside(sender: UISlider) {
		durationValueChanged(sender, snapSlider:true)
	}
	
	func durationValueChanged(slider: UISlider, snapSlider: Bool = false) {
		let newValue = Int(round(slider.value))
		let index = sliders.indexOf(slider)
		labels[index!].text = labelTextForDuration(newValue)
		NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey:userDefaultsKeys[index!])
		
		if snapSlider {
			slider.value = Float(newValue)
		}
	}
	
	func refreshInterface() {
		for (index, defaultKey) in userDefaultsKeys.enumerate() {
			let value = NSUserDefaults.standardUserDefaults().integerForKey(defaultKey)
			labels[index].text = labelTextForDuration(value)
			sliders[index].value = Float(value)
		}
	}
	
	func labelTextForDuration(duration: Int) -> String {
		return "\(duration) second" + (duration == 1 ? "" : "s")
	}
}
