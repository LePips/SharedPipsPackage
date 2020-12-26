//
//  Basic.swift
//  SharedPips
//
//  Created by Ethan Pippin on 7/2/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

#if !os(macOS)
import UIKit

public protocol NeededHeight: class {
    static var neededHeight: CGFloat { get set }
}

open class BasicTableViewCell: UITableViewCell {
    public static var identifier: String {
        return "\(self)"
    }
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupLayoutConstraints()
    }
    
    open func setupSubviews() { }
    open func setupLayoutConstraints() { }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class BasicHeaderFooterView: UITableViewHeaderFooterView {
    public static var identifier: String {
        return "\(self)"
    }
    
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class BasicTableView: UITableView {
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.separatorStyle = .none
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class BasicViewController: UIViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupLayoutConstraints()
    }
    
    open func setupSubviews() { }
    open func setupLayoutConstraints() { }
}

open class BasicNavigationController: UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = viewControllers()
    }
    
    open func viewControllers() -> [UIViewController] { return [] }
}

open class BasicView: UIView {
    private var hasLoaded = false
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupLayoutConstraints()
        if !hasLoaded {
            viewDidLoad()
            hasLoaded = true
        }
    }
    
    open func viewDidLoad() { }
    open func setupSubviews() { }
    open func setupLayoutConstraints() { }
}

open class BasicButton: UIButton {
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupLayoutConstraints()
    }
    
    open func setupSubviews() { }
    open func setupLayoutConstraints() { }
}

open class BasicCollectionViewCell: UICollectionViewCell {
    public static var identifier: String {
        return "\(self)"
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupLayoutConstraints()
    }
    
    open func setupSubviews() { }
    open func setupLayoutConstraints() { }
}

open class BasicScrollView: UIScrollView {
    public let contentView = UIView.forAutoLayout()
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        embed(contentView)
        setup()
    }
    
    public func setup() {
        setupSubviews()
        setupLayoutConstraints()
    }
    
    open func setupSubviews() { }
    open func setupLayoutConstraints() { }
}
#endif
