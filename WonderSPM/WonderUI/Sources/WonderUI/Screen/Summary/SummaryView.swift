//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/02/22.
//

import UIKit
import WonderResources
import WonderModel

// MARK: - WonderUI View
public extension WonderUI.View {
    // MARK: - SummaryView
    class SummaryView: BaseView {
        public typealias ViewModel = WonderUI.ViewModel.SummaryViewModel
        private var numberOfCharacters = 10
        
        private var tableView: UITableView = {
            let tableView = UITableView(frame: .zero, style: .plain)
            return tableView
        }()
        
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
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 100
            tableView.estimatedRowHeight = 100
            tableView.register(SummaryTableViewCell.self, forCellReuseIdentifier: SummaryTableViewCell.reuseIdentifier)
            
            addSubview(tableView)
        }
        
        public override func style() {
            backgroundColor = WonderResources.Colors.Comics.black
            tableView.backgroundColor = WonderResources.Colors.Comics.black
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.isScrollEnabled = true
            tableView.layer.masksToBounds = true
            tableView.backgroundColor = .clear
        }
        
        public func update() {
            guard let _ = model else { return }
            
            tableView.reloadData()
        }
        
        public override func setupInteraction() {
            
        }
        
        public override func layout() {
            tableView.pin
                .all(pin.safeArea)
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            
            self.layout()
        }
    }
}

// MARK: - WonderUI View UITableViewDelegate, UITableViewDataSource
extension WonderUI.View.SummaryView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let characters = model?.wonderCharacters?.prefix(numberOfCharacters) else { return 0 }
        
        return characters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.reuseIdentifier, for: indexPath) as? SummaryTableViewCell else { fatalError() }
        
        if let model = model,
           let characters = model.wonderCharacters?[indexPath.row] {
            let url = "\(characters.thumbnail?.path ?? "").\(characters.thumbnail?.thumbnailExtension ?? "")"
            
            cell.model = SummaryTableCellViewModel(name: characters.name, url: url, like: characters.like)
        }
        
        cell.isUserInteractionEnabled = false
        return cell
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.size.height,
           numberOfCharacters <= (model?.wonderCharacters?.count ?? 10) {

            numberOfCharacters += 10

            self.tableView.reloadData()
        }
    }
}
