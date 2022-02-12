//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/02/22.
//

import UIKit

// MARK: - DeckCollectionViewLayout
/// DeckCollectionViewLayout provides card stack layout for UICollectionView control.
class DeckCollectionViewLayout: UICollectionViewLayout {
    private var contentRect: CGRect = .zero
    private var cardFrame: CGRect = .zero
    private var visibleCardAttributes: [UICollectionViewLayoutAttributes] = []

    /// Amount of visible cards on screen.
    private var cardCount = 5 {
        didSet { invalidateLayout() }
    }

    /// Insets of the deck inside the content area.
    private var deckInsets = UIEdgeInsets(top: 50, left: 20, bottom: 20, right: 20) {
        didSet { invalidateLayout() }
    }

    override func prepare() {
        guard let contentInset = collectionView?.contentInset,
              let rect = collectionView?.bounds.inset(by: contentInset) else { fatalError() }
        
        contentRect = rect
        cardFrame = contentRect.inset(by: deckInsets)

        visibleCardAttributes = makeVisibleCardAttributes()
    }

    override var collectionViewContentSize: CGSize {
        return contentRect.size
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return visibleCardAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    private func makeVisibleCardAttributes() -> [UICollectionViewLayoutAttributes] {
        var result: [UICollectionViewLayoutAttributes] = []
        
        guard let numberOfItems = collectionView?.numberOfItems(inSection: 0) else { fatalError() }
        
        for item in 0 ..< numberOfItems {
            result.append(makeLayoutAttributesForItem(offset: result.count, at: IndexPath(item: item, section: 0)))
            if result.count == cardCount {
                return result
            }
        }
        return result
    }

    private func makeLayoutAttributesForItem(offset: Int? = nil, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        guard let collection = collectionView else { fatalError() }
        
        let offset = offset ?? (0 ..< indexPath.section).reduce(indexPath.item, { $0 + collection.numberOfItems(inSection: $1) })
        let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attr.frame = cardFrame
        attr.zIndex = -offset * 2
        attr.transform = .identity
        return attr
    }
}

// MARK: - CGPoint
extension CGPoint {
    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
}
