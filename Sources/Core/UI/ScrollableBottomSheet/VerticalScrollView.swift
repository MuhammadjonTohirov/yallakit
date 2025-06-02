//
//  VerticalScrollView.swift
//  TestAppForUI
//
//  Created by applebro on 30/05/25.
//

import Foundation
import UIKit

open class VerticalScrollView: UIView {
    public private(set) lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()

    public private(set) lazy var contentView: UIView = {
        UIView()
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func addSubviews() {
        appendSubviews(scrollView)
        scrollView.appendSubviews(contentView)
    }

    public func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        // use ns layout constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    public func scrollToBottom(animated: Bool = true) {
        // scroll to bottom of scroll view, count on bottom offset, and scroll if needed
        fatalError("Not implemented yet")
    }
}
