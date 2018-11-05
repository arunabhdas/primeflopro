//
//  DetailViewController.swift
//  PrimeFloPro
//
//  Created by Das on 6/2/18.
//  Copyright © 2018 arunabhdas. All rights reserved.
//

import UIKit
import MapKit
import ContactsUI
import CoreLocation
import RKCardView
import PinLayout
import MapKit

// 2) Exlore
class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
	var infoLabel: UILabel!
	var collectionView: UICollectionView!
	let imageView: UIImageView = UIImageView()
	let textLabel: UILabel = UILabel()
	let detailLabel: UILabel = UILabel()
	
	fileprivate var currentPage: Int = 0 {
		didSet {
			let flopro = self.items[self.currentPage]
			self.textLabel.text = flopro.title
			self.detailLabel.text = flopro.description
		}
	}
	
	fileprivate var pageSize: CGSize {
		let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
		var pageSize = layout.itemSize
		if layout.scrollDirection == .horizontal {
			pageSize.width += layout.minimumLineSpacing
		} else {
			pageSize.height += layout.minimumLineSpacing
		}
		return pageSize
	}
	
	
	fileprivate var items = [FloPro]()
	var collectionViewLayout: UICollectionViewFlowLayout {
		let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
		// edit properties here
		layout.itemSize = CGSize(width: Constants.MagicNumbers.kCardViewWidth, height: Constants.MagicNumbers.kCardViewHeight)
		layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
		layout.scrollDirection = UICollectionViewScrollDirection.horizontal
		layout.minimumInteritemSpacing = 0.0
		// edit properties here
		
		return layout
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.items = self.createItems()
		
		self.navigationController?.navigationBar.barTintColor = Constants.Colors.primaryColor
		self.navigationController?.navigationBar.tintColor = UIColor.white
		self.navigationController?.navigationBar.isTranslucent = false
		// view.backgroundColor = Constants.Colors.colorGreen
		
		let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
		backgroundImage.image = UIImage(named: Constants.AssetNames.kAssetBackgroundHome)
		backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
		self.view.insertSubview(backgroundImage, at: 0)
		
		title = Constants.MenuTitles.kTitleSix
		// navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .plain, target: self, action: "presentLeftMenuViewController")
		
		
		// let leftImage = UIImage.fontAwesomeIcon(name: .bars, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
		let leftImage = UIImage(named: Constants.AssetNames.kAssetBars)
		let leftImageOriginal = leftImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		// navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: "presentLeftMenuViewController")
		// navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .plain, target: self, action: "presentLeftMenuViewController")
		navigationItem.leftBarButtonItem?.tintColor = UIColor.white
		
		
		// let rightImage = UIImage.fontAwesomeIcon(name: .sliders, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
		let rightImage = UIImage(named: Constants.AssetNames.kAssetSliders)
		let rightImageOriginal = rightImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImageOriginal, style: .plain, target: self, action: "signOutTapped")
		
		self.setupLayout()
		
		self.items = self.createItems()
		
		
	}
	
	override func viewDidLayoutSubviews() {
		self.collectionView.pin.vCenter().hCenter()
		textLabel.pin.below(of: self.collectionView, aligned: .center).marginTop(50)
		// imageView.pin.below(of: textLabel, aligned: .center).marginTop(50).width(200).aspectRatio()
		detailLabel.pin.below(of: textLabel, aligned: .center).marginTop(10).width(300)
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setupLayout() {
		
		
		//flowLayout
		let flowLayout = UPCarouselFlowLayout()
		flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 60.0, height: 385.0)
		flowLayout.scrollDirection = .horizontal
		flowLayout.sideItemScale = 0.8
		flowLayout.sideItemAlpha = 1.0
		flowLayout.spacingMode = .fixed(spacing: 5.0)
		
		
		//CollectionView
		self.collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
		self.collectionView.translatesAutoresizingMaskIntoConstraints = false
		self.collectionView.register(CollectionViewProductCell.self, forCellWithReuseIdentifier: "collectionViewProductCell")
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
		self.collectionView.backgroundColor = UIColor.clear
		self.collectionView.reloadData()
		self.collectionView.showsHorizontalScrollIndicator = false
		self.collectionView.showsVerticalScrollIndicator = false
		self.collectionView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
		self.collectionView.heightAnchor.constraint(equalToConstant: 400.0).isActive = true
		
		
		
		//Image View
		
		self.imageView.translatesAutoresizingMaskIntoConstraints = false
		// imageView.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
		// imageView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
		self.imageView.image = Asset.shoppingCart.image
		
		//Text Label
		self.textLabel.translatesAutoresizingMaskIntoConstraints = false
		self.textLabel.textColor = UIColor.white
		// textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
		// textLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
		self.textLabel.text  = ""
		self.textLabel.textAlignment = .center
		
		//Description Label
		self.detailLabel.translatesAutoresizingMaskIntoConstraints = false
		self.detailLabel.textColor = UIColor.white
		// textLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
		// textLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
		self.detailLabel.text  = "Detail"
		self.detailLabel.textAlignment = .center
		
		
		self.view.addSubview(self.collectionView)
		// self.view.addSubview(imageView)
		self.view.addSubview(textLabel)
		self.view.addSubview(detailLabel)
		
		
	}
	
	func signOutTapped() {
		let alert = UIAlertController(title: "Do something", message: "With this", preferredStyle: .actionSheet)
		// perhaps use action.title here
		
		
		alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action) in
			//execute some code when this option is selected
			// let firebaseAuth = Auth.auth()
			do {
				// try firebaseAuth.signOut()
				self.dismiss(animated: true, completion: nil)
			} catch let signOutError as NSError {
				print ("Error signing out: \(signOutError.localizedDescription)")
			}
		}))
		alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) in
			//execute some code when this option is selected
		}))
		
		self.present(alert, animated: true) {
			//code to execute once the alert is showing
		}
	}
	
	fileprivate func createItems() -> [FloPro] {
		let flopros = [
			FloPro(imageName: Constants.HomeImageValues.kTitleOne, title: Constants.HomeTitleValues.kTitleOne, description: Constants.HomeDescriptionValues.kDescriptionOne),
			FloPro(imageName: Constants.HomeImageValues.kTitleTwo, title: Constants.HomeTitleValues.kTitleTwo, description: Constants.HomeDescriptionValues.kDescriptionTwo),
			FloPro(imageName: Constants.HomeImageValues.kTitleThree, title: Constants.HomeTitleValues.kTitleThree, description: Constants.HomeDescriptionValues.kDescriptionThree),
			FloPro(imageName: Constants.HomeImageValues.kTitleFour, title: Constants.HomeTitleValues.kTitleFour, description: Constants.HomeDescriptionValues.kDescriptionFour),
			FloPro(imageName: Constants.HomeImageValues.kTitleFive, title: Constants.HomeTitleValues.kTitleFive, description: Constants.HomeDescriptionValues.kDescriptionFive),
			FloPro(imageName: Constants.HomeImageValues.kTitleSix, title: Constants.HomeTitleValues.kTitleSix, description: Constants.HomeDescriptionValues.kDescriptionSix)
		]
		return flopros
	}
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	// MARK: - UICollectionViewDataSource
	
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return 6
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let collectionViewProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewProductCell", for: indexPath) as! CollectionViewProductCell
		collectionViewProductCell.contentView.backgroundColor = UIColor.white
		let flopro = items[(indexPath as NSIndexPath).row]
		collectionViewProductCell.titleLabel.text = flopro.title
		collectionViewProductCell.descriptionLabel.text = flopro.description
		collectionViewProductCell.thumbnailImageView.image = UIImage(named: flopro.imageName)
		return collectionViewProductCell
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
	{
		return CGSize(width: Constants.MagicNumbers.kCardViewWidth, height: Constants.MagicNumbers.kCardViewHeight)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
	{
		return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
	}
	
	// MARK: - UICollectionViewDelegate
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let flopro = items[(indexPath as NSIndexPath).row]
		// let alert = UIAlertController(title: flopro.title, message: nil, preferredStyle: .alert)
		// alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		// present(alert, animated: true, completion: nil)
		
		// FIXME self.performSegue(withIdentifier: "SSASideMenuToDetailSecondSegue", sender: nil)
		
		// let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailSecondViewController") as! DetailSecondViewController
		// let modalStyle = UIModalTransitionStyle.coverVertical
		// viewController.modalTransitionStyle = modalStyle
		// self.present(viewController, animated: true, completion: nil)
		
	}
	
	
	// MARK: - UIScrollViewDelegate
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
		let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
		let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
		currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
		
	}
	
	
}
