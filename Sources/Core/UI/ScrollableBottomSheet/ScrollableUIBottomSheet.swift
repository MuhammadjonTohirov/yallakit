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
    lazy var yOffset: CGFloat = initialYOffset
    var yOffsetShift: CGFloat = .zero
    var initialYOffset: CGFloat = 500
    var content: UIHostingController<AnyView>
    private var handleView = UIView()
    private var lastContentOffset: CGPoint = .zero
    private var lastBodyYOffset: CGFloat = .zero
    private var isDecelerating: Bool = false
    
    var onExpanded: () -> Void = {}
    var onCollapsed: () -> Void = {}
    
    var isExpanded: Bool {
        self.yOffsetShift > 0
    }
    
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
        clearBody()
        self.content.rootView = AnyView(content())
        self.content.view.setNeedsDisplay()
        self.content.view.setNeedsLayout()
        initView()
        updateScrollViewFrame()
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
        
        let maxPossibleScrollViewHeight: CGFloat = scrollView.scrollView.contentSize.height - 1
        let maxPossibleScrollContentHeight: CGFloat = frame.height - 100
        let maxY = frame.height - maxPossibleScrollViewHeight
        let _maxY = min(maxY, initialYOffset)
        let y = max(initialYOffset - yOffsetShift, _maxY)
        let height = frame.height - 100
        
        let minContentHeight = max(scrollView.scrollView.contentSize.height, maxPossibleScrollContentHeight)
        
        scrollView
            .frame = .init(
                x: 0,
                y: y,
                width: frame.width,
                height: height
            )
        let handleHeight: CGFloat = 6
        let width: CGFloat = 32
        handleView.frame = .init(
            x: scrollView.frame.width / 2 - width / 2,
            y: scrollView.frame.origin.y + 8 + scrollView.contentView.frame.origin.y,
            width: width,
            height: handleHeight
        )
        
        scrollView.scrollView.contentSize.height = minContentHeight
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
        let maxYOffset = initialYOffset
        
        let maxShift = abs(maxYOffset - minYOffset).rounded(.down)

        let isScrollingUp = deltaY > 0
        if (yOffsetShift < maxShift && deltaY > 0) || (yOffsetShift > 0 && deltaY < 0) {
            let sh1 = max(yOffsetShift + deltaY, 0)
            let sh2 = maxShift
            yOffsetShift = min(sh1, sh2)
            scrollView.contentOffset = .zero
            updateScrollViewFrame()
        } else {
            if !isScrollingUp {
                scrollView.contentOffset = .zero
            }
        }
        
        if isDecelerating {
            tryFinalizeOpenClose()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        debugPrint("Scrollview", "will begin dragging")
        lastContentOffset = scrollView.contentOffset
        lastBodyYOffset = self.scrollView.frame.origin.y
        isDecelerating = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        debugPrint("Scrollview", "did end dragging")
        tryFinalizeOpenClose()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        debugPrint("Scrollview", "will begin decelerating")
        isDecelerating = true
        tryFinalizeOpenClose()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        debugPrint("Scrollview", "did end decelerating")
        
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        debugPrint("Scrollview", "did scrolls to top")
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        debugPrint("Scrollview", "did end scrolling animation")
        tryFinalizeOpenClose()
    }
    
    private func tryFinalizeOpenClose() {
        let offsetY = self.scrollView.frame.origin.y
        let change = lastBodyYOffset - offsetY
        if change == 0 { return }
        
        let isClosing = change < 0
        
        self.layoutIfNeeded()
        
        func animate() {
            if !isClosing {
                expand()
            } else {
                collapse()
            }
        }
        
        func onFinishAnimate() {
            self.scrollView.scrollView.isScrollEnabled = true
        }
        
        if #available(iOS 18, *) {
            self.scrollView.scrollView.stopScrollingAndZooming()
            UIView.animate(.spring(duration: 0.3), changes: {
                animate()
            }, completion: {
                onFinishAnimate()
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                if self == nil { return }
                animate()
            } completion: { _ in
                onFinishAnimate()
            }
        }
    }
    
    func expand(animate: Bool = false) {
        func expand() {
            let minYOffset: CGFloat = max(100, frame.height - self.scrollView.scrollView.contentSize.height)
            let maxYOffset = initialYOffset
            
            self.yOffsetShift = maxYOffset - minYOffset
            self.updateScrollViewFrame()
        }
        
        if #available(iOS 18, *) {
            UIView.animate(.spring(duration: 0.3), changes: {
                expand()
            }) { [weak self] in
                self?.onExpanded()
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                guard self != nil else { return }
                expand()
            }, completion: {[weak self] _ in
                self?.onExpanded()
            })
        }
    }
    
    func collapse(animate: Bool = false) {
        func collapse() {
            self.yOffsetShift = 0
            self.updateScrollViewFrame()
        }
        
        if #available(iOS 18, *) {
            UIView.animate(.spring(duration: animate ? 0.3 : 0), changes: {
                collapse()
            }) { [weak self] in
                self?.onCollapsed()
            }
        } else {
            UIView.animate(withDuration: animate ? 0.3 : 0, delay: 0, options: .curveEaseInOut, animations: {
                [weak self] in
                    guard self != nil else { return }
                    collapse()
            }, completion: {[weak self] _ in
                self?.onCollapsed()
            })
        }
    }
}

