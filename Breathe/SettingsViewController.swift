import UIKit

let BreatheInTimeKey = "Breathe in time"
let PauseTimeAfterBreathInKey = "Pause time after breath in"
let BreatheOutTimeKey = "Breathe out time"
let PauseTimeAfterBreathOutKey = "Pause time after breath out"

class SettingsViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		println("Settings controller loaded")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		
		println("Settings controller appears")
		
		
	}
	
	//TODO: provide feedback on the sliders
	//TODO: set NSUserDefaults with slider values
}

