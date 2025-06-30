//
//  ScrollableUIBottomSheet.swift
//  TestAppForUI
//
//  Created by applebro on 30/05/25.
//

import Foundation
import UIKit
import SwiftUI

final class ScrollableUIBottomSheet: UIView {
    typealias Content = View
    var scrollView: VerticalScrollView = .init()
    lazy var yOffset: CGFloat = maxYOffset
    var yOffsetShift: CGFloat = .zero
    
    var maxYOffset: CGFloat = 500
    
    var content: UIHostingController<AnyView>
    private var handleView = UIView()
    private var lastContentOffset: CGPoint = .zero
    private var lastBodyYOffset: CGFloat = .zero
    
    var onExpanded: () -> Void = {}
    var onCollapsed: () -> Void = {}
    
    var isExpanded: Bool = false
    
    init(content: @escaping () -> any Content) {
        self.content = UIHostingController(
            rootView: AnyView(content())
        )
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var _didMoveToSuperview = false
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if _didMoveToSuperview {
            return
        }
        
        _didMoveToSuperview = true
        initView()
    }
    
    private func initView() {
        addSubview(scrollView)
        addSubview(handleView)
        scrollView.contentView.addSubview(content.view)
        setupConstraints()
        setupView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.setNeedsLayout()
        }
    }
    
    private func clearBody() {
        scrollView.removeFromSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateScrollViewFrame()
    }
    
    func setContent(_ content: @escaping () -> any Content) {
        self.clearBody()
        self.scrollView.contentView.subviews.forEach({$0.removeFromSuperview()})
        
        self.content.rootView = AnyView(content())
        self.initView()
    }

    private var minHeight: CGFloat = .zero
    
    func setMinHeight(_ height: CGFloat) {
        guard minHeight != height else { return }
        
        self.minHeight = height
        self.maxYOffset = self.frame.height - height
        debugPrint("Min height", minHeight, maxYOffset, self.frame.height)
    }

    func setupView() {
        handleView.backgroundColor = .systemGray4
        handleView.layer.cornerRadius = 3

        scrollView.scrollView.delegate = self
        scrollView.scrollView.isDirectionalLockEnabled = true
        scrollView.backgroundColor = .systemBackground
        setRadius(20)
    }
    
    func setRadius(_ radius: CGFloat) {
        self.addShadow(
            color: UIColor.black.withAlphaComponent(0.08),
            offset: .init(width: 0, height: -10),
            radius: 10
        )
        self.scrollView.layer.cornerRadius = radius
        self.scrollView.clipsToBounds = true
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subview in subviews {
            if let vScroll = subview as? VerticalScrollView {
                let pointInScroll = convert(point, to: vScroll)
                
                if vScroll.bounds.contains(pointInScroll) {
                    return super.hitTest(point, with: event)
                }
                
                return nil
            }
        }
        return super.hitTest(point, with: event)
    }
    
    func updateScrollViewFrame() {
        let maxPossibleScrollContentHeight: CGFloat = frame.height - 100

        let y = (maxYOffset - yOffsetShift).limitBottom(100).limitTop(maxYOffset)
        let minOffsetY: CGFloat = 100
        let maxOffsetY: CGFloat = maxYOffset
        
        let height = frame.height - 100
        scrollView
            .frame = .init(
                x: 0,
                y: isExpanded ? minOffsetY : maxOffsetY,
                width: frame.width,
                height: height
            )
        debugPrint("UpdateFrame", scrollView.frame, isExpanded)
        let minContentHeight = max(scrollView.scrollView.contentSize.height, maxPossibleScrollContentHeight + 1)
        
        scrollView.scrollView.contentSize.height = minContentHeight
        
        let handleHeight: CGFloat = 6
        let width: CGFloat = 32
        handleView.frame = .init(
            x: scrollView.frame.width / 2 - width / 2,
            y: scrollView.frame.origin.y + 8,
            width: width,
            height: handleHeight
        )
        
        scrollView.backgroundColor = .systemBackground
        scrollView.contentView.backgroundColor = .systemBackground
    }
    
    private func updateTransition(by shift: CGFloat) {
        let maxPossibleScrollViewHeight: CGFloat = scrollView.scrollView.contentSize.height - 1

        let maxY = frame.height - maxPossibleScrollViewHeight
        let _maxY = min(maxY, maxYOffset)
        let y = max(maxYOffset - shift, _maxY)
        
        scrollView.frame.origin.y = y
        
        handleView.frame.origin.y = scrollView.frame.origin.y + 8
    }
    
    private func setupConstraints() {
        content
            .view
            .translatesAutoresizingMaskIntoConstraints = false
        
        content
            .view.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor).isActive = true
        
        content.view.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor).isActive = true
        
        content.view.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor).isActive = true
        
        content.view.bottomAnchor.constraint(equalTo: scrollView.contentView.bottomAnchor).isActive = true
    }
}

extension ScrollableUIBottomSheet: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let deltaY = scrollView.contentOffset.y
        let minYOffset: CGFloat = max(100, frame.height - scrollView.contentSize.height)
        let maxYOffset = maxYOffset
        
        let maxShift = abs(maxYOffset - minYOffset).rounded(.down)

        let isScrollingUp = deltaY > 0
        if (yOffsetShift < maxShift && deltaY > 0) || (yOffsetShift > 0 && deltaY < 0) {
            let sh1 = max(yOffsetShift + deltaY, 0)
            let sh2 = maxShift
            yOffsetShift = min(sh1, sh2)
            scrollView.contentOffset = .zero
            updateTransition(by: yOffsetShift)
        } else {
            if !isScrollingUp {
                scrollView.contentOffset = .zero
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        debugPrint("Scrollview", "will begin dragging")
        lastContentOffset = scrollView.contentOffset
        lastBodyYOffset = self.scrollView.frame.origin.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        debugPrint("Scrollview", "did end dragging", decelerate)
        if !decelerate {
            onEndScrollInteraction()
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        debugPrint("Scrollview", "will begin decelerating")
        onEndScrollInteraction()
    }
    
    private func onEndScrollInteraction() {
        
        let velo = scrollView.scrollView.panGestureRecognizer.velocity(in: self)
        
        guard self.scrollView.frame.origin.y != lastBodyYOffset else { return }
        let isUp = self.scrollView.frame.origin.y < lastBodyYOffset
        let diff = abs(self.scrollView.frame.origin.y - lastBodyYOffset)
        debugPrint(isUp, diff, velo)
        
        if isUp {
            (diff > 100 || abs(velo.y) > 300) ? expand(animate: true) : collapse(animate: true)
            return
        }
        
        if !isUp {
            if diff > 100 || velo.y > 300 {
                collapse(animate: true)
            } else {
                expand(animate: true)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        debugPrint("Scrollview", "did end decelerating")
        
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        debugPrint("Scrollview", "did scrolls to top")
    }
    
    func expand(animate: Bool = false) {
        func expand() {
            let minYOffset: CGFloat = 100
            let maxYOffset = maxYOffset
            
            self.yOffsetShift = maxYOffset - minYOffset
            debugPrint("expand", yOffsetShift)
            updateTransition(by: yOffsetShift)
        }
        self.scrollView.scrollView.isScrollEnabled = false
        
        UIView.animate(withDuration: 0.33, delay: 0, options: .beginFromCurrentState, animations: { [weak self] in
            guard self != nil else { return }
            expand()
        }, completion: {[weak self] _ in
            self?.onExpanded()
            self?.isExpanded = true
            self?.scrollView.scrollView.isScrollEnabled = true
        })
    }
    
    func collapse(animate: Bool = false) {
        func collapse() {
            self.yOffsetShift = 0
            self.updateTransition(by: yOffsetShift)
        }
        
        self.scrollView.scrollView.isScrollEnabled = false
        UIView.animate(withDuration: animate ? 0.33 : 0, delay: 0, options: .beginFromCurrentState, animations: {
            [weak self] in
                guard self != nil else { return }
                collapse()
        }, completion: {[weak self] _ in
            self?.onCollapsed()
            self?.isExpanded = false
            self?.scrollView.scrollView.isScrollEnabled = true
        })
    }
}

