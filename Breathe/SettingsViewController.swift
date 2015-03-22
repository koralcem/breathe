import UIKit

let BreatheInTimeKey = "Breathe in time"
let PauseTimeAfterBreathInKey = "Pause time after breath in"
let BreatheOutTimeKey = "Breathe out time"
let PauseTimeAfterBreathOutKey = "Pause time after breath out"

class SettingsViewController: UIViewController {

	@IBOutlet weak var BreatheInTimeLabel: UILabel!
	@IBOutlet weak var PauseAfterBreathInTimeLabel: UILabel!
	@IBOutlet weak var BreatheOutTimeLabel: UILabel!
	@IBOutlet weak var PauseAfterBreathOutTimeLabel: UILabel!
	
	@IBOutlet weak var BreatheInTimeSlider: UISlider!
	@IBOutlet weak var PauseAfterBreatheInTimeSlider: UISlider!
	@IBOutlet weak var BreatheOutTimeSlider: UISlider!
	@IBOutlet weak var PauseAfterBreathOutTimeSlider: UISlider!
	
	var controlMapping: Dictionary<UISlider, (label:UILabel, defaultsKey:String)> = Dictionary<UISlider, (label:UILabel, defaultsKey:String)>()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		println("Settings controller loaded")
		
		controlMapping[BreatheInTimeSlider] = (BreatheInTimeLabel, BreatheInTimeKey)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		println("Settings controller appears")
	}
	
	@IBAction func sliderValueChanged(sender: UISlider) {
		let newValue = Int(round(sender.value))
		println("Slider moved to \(newValue)")
		controlMapping[sender].label.text = "\(newValue) seconds"
		
		BreatheInTimeLabel.text = "\(newValue) seconds"
		NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey:BreatheInTimeKey)

	}
	//TODO: provide feedback on the sliders
	//TODO: set NSUserDefaults with slider values
}

