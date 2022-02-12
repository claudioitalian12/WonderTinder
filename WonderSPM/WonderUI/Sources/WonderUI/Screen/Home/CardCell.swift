//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/02/22.
//

import UIKit
import Kingfisher
import WonderResources

// MARK: - CardCellViewModel
struct CardCellViewModel: UIModuleViewModel {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - CardCell
class CardCell: UICollectionViewCell {
    public static let reuseIdentifier = "CardCell"
    
    private let profileImage = UIImageView()
    private let profileName = UILabel()
    private let layerView = UIView()
    
    public var model: CardCellViewModel? {
        didSet {
            self.update()
        }
    }

    lazy private var gradientLayer: CAGradientLayer = {
        var gradientColorOne : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        var gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]

        return gradientLayer
    }()

    lazy private var animation: CABasicAnimation = {

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.0
        animation.repeatCount = .infinity

        return animation
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.model = nil
        self.profileName.text = nil
        self.profileImage.image = nil
        self.gestureRecognizers = nil
    }
    
   override init(frame: CGRect) {
       super.init(frame: frame)
       
       setup()
       style()
   }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    private func setup() {
        contentView.addSubview(profileImage)
        contentView.addSubview(profileName)
        contentView.addSubview(layerView)
    }
    
    private func style() {
        backgroundColor = .lightGray
        layer.cornerRadius = 20.0
        layer.masksToBounds = true

        profileImage.contentMode = .scaleAspectFill
        profileName.font = WonderResources.Fonts.Comics.get(.Bold, size: 30)
        profileName.backgroundColor = WonderResources.Colors.Comics.white
        profileName.textColor = WonderResources.Colors.Comics.black
        profileName.textAlignment = .center
        profileName.numberOfLines = 0
        profileName.layer.cornerRadius = 20.0
        profileName.layer.borderWidth = 0.5
        profileName.layer.masksToBounds = true
        profileName.layer.borderColor = WonderResources.Colors.Comics.black?.cgColor
        
        layerView.translatesAutoresizingMaskIntoConstraints = false
        layerView.layer.cornerRadius = 7.0
        layerView.layer.masksToBounds = true
        layerView.layer.contentsGravity = CALayerContentsGravity.center
        layerView.tintColor = .lightGray
    }
    
    private func layout() {
        profileImage.pin
            .all()
        
        profileName.pin
            .bottom()
            .right()
            .left()
            .minHeight(50.0)
            .maxHeight(self.frame.width - 50.0)
            .sizeToFit(.width)
        
        layerView.pin
            .all()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func update() {
        guard let model = model else { return }
        profileName.isHidden = false
        profileName.text = model.name
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        if model.url == "." {
            profileImage.image = WonderResources.UI.Comics.loaderWonder
            profileName.isHidden = true
            self.removeGradientLayer()
            return
        }
        
        let url = URL(string: model.url)
        profileImage.kf.setImage(
            with: url,
            options: [.cacheOriginalImage])
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.removeGradientLayer()
            case .failure(let error):
                print("\("download_fail".localized): \(error.localizedDescription)")
            }
        }
    }
    
    public func addShimmer() {
        addAnimationAndGradientLayer()
    }
    
    private func addAnimationAndGradientLayer() {

        if let _ = (layerView.layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
            print("layer_exist".localized)
        } else {
            gradientLayer.add(animation, forKey: animation.keyPath)
            layerView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }

    private func removeGradientLayer() {
        layerView.layer.sublayers?.removeAll()
        gradientLayer.removeFromSuperlayer()
    }
}
