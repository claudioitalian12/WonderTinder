//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/02/22.
//

import UIKit
import PinLayout
import WonderNetwork
import WonderModel
import WonderResources

// MARK: - WonderUI View
public extension WonderUI.View {
    // MARK: - HomeView
    class HomeView: BaseView {
        public typealias ViewModel = WonderUI.ViewModel.HomeViewModel
        private let scrollView = UIScrollView()
        private let marvelLogo = UIImageView(image: WonderResources.UI.Comics.loveMarvel)
        private let decisionSummaryButton = UIButton()
        private let declineButton = UIButton()
        private let acceptButton = UIButton()
        
        private var collectionView: UICollectionView = {
            let layout = DeckCollectionViewLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            return collectionView
        }()
        
        public var updateContent: (() -> ())?
        public var didTapSummaryButton: (() -> ())?
        public var model: ViewModel? {
            didSet {
                update()
            }
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.setup()
            self.style()
            self.setupInteraction()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func setup() {
            collectionView.dataSource = self
            collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseIdentifier)

            addSubview(scrollView)
            scrollView.addSubview(marvelLogo)
            scrollView.addSubview(decisionSummaryButton)
            scrollView.addSubview(declineButton)
            scrollView.addSubview(acceptButton)
            scrollView.addSubview(collectionView)
        }
        
        public override func setupInteraction() {
            decisionSummaryButton.addTarget(self, action: #selector(showSummary), for: .touchUpInside)

            acceptButton.addTarget(self, action: #selector(acceptAction), for: .touchUpInside)

            declineButton.addTarget(self, action: #selector(declineAction), for: .touchUpInside)
        }
        
        public override func style() {
            backgroundColor = WonderResources.Colors.Comics.black
            
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.isScrollEnabled = true
            collectionView.layer.masksToBounds = false
            collectionView.backgroundColor = .clear

            scrollView.showsVerticalScrollIndicator = false
            
            marvelLogo.contentMode = .scaleAspectFit
            marvelLogo.layer.masksToBounds = true
            marvelLogo.layer.cornerRadius = 20.0
            
            decisionSummaryButton.setTitle("summary".localized,
                                  for: .normal)
            decisionSummaryButton.setTitleColor(WonderResources.Colors.Comics.black,
                                       for: .normal)
            decisionSummaryButton.titleLabel?.textAlignment = .center
            decisionSummaryButton.layer.cornerRadius = 10.0
            decisionSummaryButton.backgroundColor = WonderResources.Colors.Comics.white
            decisionSummaryButton.titleLabel?.font = WonderResources.Fonts.Comics.get(.Medium, size: 20)
                        
            declineButton.setImage(WonderResources.UI.Comics.brokenHeart, for: .normal)
            declineButton.titleLabel?.textAlignment = .center
            declineButton.layer.cornerRadius = 25.0
            declineButton.backgroundColor = WonderResources.Colors.Comics.white
            declineButton.titleLabel?.font = WonderResources.Fonts.Comics.get(.Medium, size: 20)
            
            acceptButton.setImage(WonderResources.UI.Comics.heart, for: .normal)
            acceptButton.titleLabel?.textAlignment = .center
            acceptButton.layer.cornerRadius = 25.0
            acceptButton.backgroundColor = WonderResources.Colors.Comics.white
            acceptButton.titleLabel?.font = WonderResources.Fonts.Comics.get(.Medium, size: 20)
        }
        
        public func update() {
            guard let _ = model else { return }
            
            collectionView.reloadData()
        }
        
        public override func layout() {
            scrollView.pin
                .all(pin.safeArea)
            
            marvelLogo.pin
                .top(20.0)
                .height(80.0)
                .right(20.0)
                .left(20.0)
            
            collectionView.pin
                .marginTop(10%)
                .below(of: marvelLogo)
                .hCenter()
                .width(320.0)
                .height(350.0)
            
            declineButton.pin
                .height(50.0)
                .width(50.0)
                .hCenter(-75.0)
                .marginTop(15.0)
                .below(of: collectionView)

            acceptButton.pin
                .height(50.0)
                .width(50.0)
                .hCenter(75.0)
                .marginTop(15.0)
                .below(of: collectionView)
            
            decisionSummaryButton.pin
                .right(20.0)
                .left(20.0)
                .height(50.0)
                .marginTop(50.0)
                .below(of: acceptButton)
            
            scrollView.contentSize.height = decisionSummaryButton.frame.maxY
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            
            self.layout()
        }
        
        private func refreshCollection(like: Bool) {
            guard let results = self.model?.wonderCharacters?.data.results else { return }
            if let saveElement = results.first,
               results.count > 1 {
                saveElement.like = like
                WonderModel.Marvel.share.saveModel(saveElement)
                self.model?.wonderCharacters?.data.results.removeFirst()
                self.collectionView.reloadData()
                self.updateContent?()
            } else {
                self.updateContent?()
            }
        }
        
        private func cardButtonAnimation(transform: CATransform3D) {
            guard let cell = self.collectionView.visibleCells.first(where: { cell in
                cell.tag == 0
            }) else { return }
            
            UIView.animate(withDuration: 0.3, animations: {
                cell.alpha = 0
                cell.layer.transform = transform
            }, completion: { [weak self] _ in
                guard let self = self else { return }
                self.refreshCollection(like: false)
            })
        }
    }
}

// MARK: - HomeView UICollectionViewDataSource
extension WonderUI.View.HomeView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = model else { return 0 }
        return model.wonderCharacters?.data.results.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell else { fatalError() }
        cell.transform = .identity
        cell.tag = indexPath.row
        cell.addShimmer()
        
        if let model = model,
           let characters = model.wonderCharacters?.data.results[indexPath.row] {
            let url = "\(characters.thumbnail?.path ?? "").\(characters.thumbnail?.thumbnailExtension ?? "")"
            
            cell.model = CardCellViewModel(name: characters.name, url: url)
        }
        
        cell.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
        
        return cell
    }
}

// MARK: - HomeView objective extesion
@objc extension WonderUI.View.HomeView {
    private func showSummary() {
        didTapSummaryButton?()
    }
    
    private func declineAction() {
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, -0.15, 0, 0, 1)
        transform = CATransform3DTranslate(transform, -(self.frame.width * 2), 0, 1)
        self.cardButtonAnimation(transform: transform)
    }
    
    private func acceptAction() {
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, 0.15, 0, 0, 1)
        transform = CATransform3DTranslate(transform, (self.frame.width * 2), 0, 1)
        self.cardButtonAnimation(transform: transform)
    }
    
    private func handlePanGesture(sender: UIPanGestureRecognizer) {
        guard let card = sender.view else { return }
        let point = sender.translation(in: self)
        
        card.pin
            .hCenter(point.x)
            .vCenter(point.y)
                               
        switch sender.state {
        case .ended:
            if (card.center.x) > 400 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.pin
                        .right(-card.frame.width)
                    card.alpha = 0
                }, completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.refreshCollection(like: true)
                })
                return
            }else if card.center.x < -65 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.pin
                        .left(-card.frame.width)
                    card.alpha = 0
                }, completion: { [weak self] _ in
                    guard let self = self else { return }
                    self.refreshCollection(like: false)
                })
                return
            }
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.pin
                    .hCenter()
                    .vCenter(15)
            }
        case .changed:
            let rotation = tan(point.x / (self.collectionView.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
            return
        default:
            break
        }
    }
}
