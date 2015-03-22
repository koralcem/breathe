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
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
	}
	
	@IBAction func sliderValueChanged(sender: UISlider) {
		let newValue = Int(round(sender.value))
		let idx = find(sliders, sender)
		labels[idx!].text = "\(newValue) seconds"
		NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey:userDefaultsKeys[idx!])
	}
}

