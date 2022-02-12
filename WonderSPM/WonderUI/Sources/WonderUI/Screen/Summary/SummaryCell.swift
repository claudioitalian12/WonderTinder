//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/02/22.
//

import UIKit
import PinLayout
import WonderResources

// MARK: - SummaryTableCellViewModel
struct SummaryTableCellViewModel: UIModuleViewModel {
    public let name: String
    public let url: String
    public let like: Bool
    
    init(name: String, url: String, like: Bool) {
        self.name = name
        self.url = url
        self.like = like
    }
}

// MARK: - SummaryTableViewCell
class SummaryTableViewCell: UITableViewCell {
    public static let reuseIdentifier = "SummaryTableViewCell"
    private let profileImage = UIImageView()
    private let profileName = UILabel()
    private let likeStatus = UILabel()
    
    public var model: SummaryTableCellViewModel? {
        didSet {
            self.update()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
        self.style()
    }
    
    private func setup() {
        contentView.addSubview(profileImage)
        contentView.addSubview(profileName)
        contentView.addSubview(likeStatus)
    }
    
    private func style() {
        backgroundColor = WonderResources.Colors.Comics.black
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 40.0
        
        profileName.font = WonderResources.Fonts.Comics.get(.Bold, size: 15)
        profileName.backgroundColor = WonderResources.Colors.Comics.black
        profileName.textColor = WonderResources.Colors.Comics.white
        profileName.textAlignment = .left
        profileName.layer.masksToBounds = true
        profileName.layer.borderColor = WonderResources.Colors.Comics.black?.cgColor
        
        likeStatus.font = WonderResources.Fonts.Comics.get(.Bold, size: 10)
        likeStatus.backgroundColor = WonderResources.Colors.Comics.black
        likeStatus.textColor = WonderResources.Colors.Comics.white
        likeStatus.textAlignment = .left
        likeStatus.layer.masksToBounds = true
        likeStatus.layer.borderColor = WonderResources.Colors.Comics.black?.cgColor
    }
    
    public func setupCell(image: String) {
        profileImage.image = UIImage(named: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        profileImage.pin
            .left(5.0)
            .vCenter()
            .height(80.0)
            .width(80.0)
    
        profileName.pin
            .left(100.0)
            .height(50.0)
            .right()
            .top()
        
        likeStatus.pin
            .below(of: profileName)
            .height(10.0)
            .left(100.0)
            .right()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    private func update() {
        guard let model = model else { return }
        profileName.text = model.name
        likeStatus.text = model.like ? "like".localized:"not_like".localized
        
        let url = URL(string: model.url)
        profileImage.kf.setImage(
            with: url)
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.setNeedsLayout()
                self.layoutIfNeeded()
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
