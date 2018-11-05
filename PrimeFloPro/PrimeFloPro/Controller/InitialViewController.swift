//
//  InitialViewController.swift
//  PrimeFloPro
//

import UIKit

class InitialViewController: UIViewController {

	@IBAction func buttonTapped(_ sender: Any) {
		self.performSegue(withIdentifier: "InitialToFirstViewController", sender: nil)
	}
	@IBAction func gameCentralButtonTapped(_ sender: Any) {
				self.performSegue(withIdentifier: "InitialToSecondViewController", sender: nil)
	}
	@IBAction func interiorsButtonTapped(_ sender: Any) {
			self.performSegue(withIdentifier: "InitialToThirdViewController", sender: nil)
	}
	@IBAction func launchButtonTapped(_ sender: Any) {
		self.performSegue(withIdentifier: "InitialToLaunchSegue", sender: nil)
	}
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
