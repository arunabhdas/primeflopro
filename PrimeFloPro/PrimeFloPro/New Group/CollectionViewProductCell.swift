//
//  CollectionViewProductCell.swift
//  PrimeFloPro
//

import UIKit

class CollectionViewProductCell: UICollectionViewCell {
	var thumbnailImageView: UIImageView = UIImageView()
	var titleLabel: UILabel = UILabel()
	var descriptionLabel: UILabel = UILabel()
	var cntView: UIView = UIView()
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.layer.cornerRadius = 5
		thumbnailImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: Constants.MagicNumbers.kCardViewHeight)
		titleLabel.frame = CGRect(x: 60, y: 0, width: self.frame.width - 10, height: 60)
		titleLabel.textColor = UIColor.white
		// FIXME descriptionLabel.frame = CGRect(x: 200, y: 10, width: self.frame.width - 20, height: 25)
		// FIXME descriptionLabel.textColor = UIColor.white
		self.titleLabel.font = UIFont(name: Constants.FontProperties.kFontName, size: Constants.FontProperties.kFontSize)
		// thumbnailImageView.image = Asset.shoppingCart.image
		
		DispatchQueue.main.async {
			self.cntView.layer.shadowColor = UIColor.gray.cgColor
			self.cntView.layer.shadowOpacity = 0.5
			self.cntView.layer.shadowOpacity = 10.0
			self.cntView.layer.shadowOffset = .zero
			self.cntView.layer.shadowPath = UIBezierPath(rect: self.cntView.bounds).cgPath
			self.cntView.layer.shouldRasterize = true
			
		}
		self.addSubview(thumbnailImageView)
		self.addSubview(cntView)
		self.addSubview(titleLabel)
		// FIXME self.addSubview(descriptionLabel)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
