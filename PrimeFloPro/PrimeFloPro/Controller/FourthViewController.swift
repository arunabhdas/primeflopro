//
//  FourthViewController.swift
//  PrimeFloPro
//


import UIKit
import Cupcake

class FourthViewController: UITableViewController {
	
	var appList: Array<Dictionary<String, Any>>!
	
	
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return appList.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppStoreCell
		let app = self.appList[indexPath.row]
		cell.update(app: app, index: indexPath.row)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.barTintColor = Constants.Colors.primaryColor
		self.navigationController?.navigationBar.isTranslucent = false
		view.backgroundColor = Constants.Colors.primaryColor
		
		// let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
		// backgroundImage.image = UIImage(named: Constants.AssetNames.kAssetBackground)
		// backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
		// self.view.insertSubview(backgroundImage, at: 0)
		
		
		title = Constants.TabTitles.kTitleFour
		/*
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: "presentLeftMenuViewController")
		*/
		
		// let leftImage = UIImage.fontAwesomeIcon(name: .bars, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
		let leftImage = UIImage(named: Constants.AssetNames.kAssetBars)
		// let leftImage = UIImage.fontAwesomeIcon(name: FontAwesome.github, textColor: UIColor.black, size: CGSize(width: 30, height: 30))
		// let leftImageOriginal = leftImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: "presentLeftMenuViewController")
		
		
		/*
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .Plain, target: self, action: "presentRightMenuViewController")
		*/
		
		// let rightImage = UIImage.fontAwesomeIcon(name: .sliders, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
		let rightImage = UIImage(named: Constants.AssetNames.kAssetSliders)
		let rightImageOriginal = rightImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImageOriginal, style: .plain, target: self, action: "signOutTapped")
		self.tableView.estimatedRowHeight = 84
		self.tableView.register(AppStoreCell.self, forCellReuseIdentifier: "cell")
		self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 34, 0)
		
		let path = Bundle.main.path(forResource: "appList", ofType: "plist")
		appList = NSArray(contentsOfFile: path!) as? Array<Dictionary<String, Any>>
		for _ in 1..<5 { appList.append(contentsOf: appList) }
		
	}
	func signOutTapped() {
		let alert = UIAlertController(title: "Select Action", message: "Please make your selection", preferredStyle: .actionSheet)
		// perhaps use action.title here
		
		alert.addAction(UIAlertAction(title: "New", style: .default, handler: { (action) in
			//execute some code when this option is selected
			// self.newGigCard()
		}))
		
		alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action) in
			//execute some code when this option is selected
			
			do {
				
				self.dismiss(animated: true, completion: nil)
			} catch let signOutError as NSError {
				print ("Error signing out: \(signOutError.localizedDescription)")
			}
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
			//execute some code when this option is selected
		}))
		
		self.present(alert, animated: true) {
			//code to execute once the alert is showing
		}
	}
}
