//
//  DraggableBottomSheetViewModel.swift
//  TestApp
//
//  Created by Muhammadjon Tohirov on 08/07/25.
//

import Foundation
import SwiftUI
import Combine

final class DraggableBottomSheetViewModel: NSObject, ObservableObject {
    
    @MainActor
    @Published var lastOffset: CGFloat = 0
    @Published var scrollOffset: CGPoint = .zero
    @Published var scrollAtTop: Bool = true
    @Published var isScrollEnabled: Bool = true
    @Published var dragState: DragState = .normal
    @Published var progress: CGFloat = 0
    
    private var decelerating: Bool?
    private var isDisimssing: Bool?
    private var scrollView: UIScrollView?

    var cancellables: Set<AnyCancellable> = []
    var maxDragDistance: CGFloat = 0
    
    @Published var offset: CGFloat = 0 {
        didSet {
            progress = (1 - (offset / maxDragDistance).clamped(to: 0...1))
        }
    }
    
    func onAppear() {
        subscribeToDragState()
    }
    
    @MainActor
    func setScrollView(_ scrollView: UIScrollView?) {
        self.scrollView = scrollView
        self.scrollView?.delegate = self
    }
    
    @MainActor
    func setScrollViewOffset(_ offset: CGPoint) {
        self.scrollView?.setContentOffset(offset, animated: false)
    }
    
    private func subscribeToDragState() {
        
    }
    
    func expand() {
        withAnimation(.spring(duration: 0.25)) {
            self.offset = 0
        }
    }
    
    func collapse() {
        withAnimation(.spring(duration: 0.25)) {
            self.offset = maxDragDistance
        }
    }
}

extension DraggableBottomSheetViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        withTransaction(.init(animation: nil)) {
            if decelerating == true && scrollView.contentOffset.y < 0 {
                self.stopScrolling()
            }
            
            func setOffset(_ offset: CGFloat) {
                withAnimation {
                    self.offset = offset.limitBottom(0).limitTop(maxDragDistance)
                }
            }
            
            let offsetY = scrollView.contentOffset.y
            
            if offsetY < 0 {
                self.isDisimssing = true
                setOffset(offset + abs(offsetY))
                scrollView.contentOffset.y = 0
            }
            
            if offsetY >= 0 {
                if isDisimssing == true {

                    if self.offset - abs(offsetY) < 0 {
                        self.isDisimssing = nil
                    }

                    setOffset(offset - abs(offsetY))
                                    
                    scrollView.contentOffset.y = 0
                }

            }
            
            lastOffset = offset
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.decelerating = decelerate

        if offset < 60 {
            self.expand()
        } else {
            self.collapse()
        }
        
        if decelerate && isDisimssing == true {
            self.stopScrolling()
            self.collapse()
        }
    }
    
    @MainActor
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.decelerating = false
        
        if offset < 60 {
            self.expand()
        } else {
            self.collapse()
        }
    }
    
    @MainActor
    private func stopScrolling() {
        if #available(iOS 17.4, *) {
            scrollView?.stopScrollingAndZooming()
            scrollView?.setContentOffset(.zero, animated: false)
            decelerating = nil
        } else {
            
            self.scrollView?.setContentOffset(.zero, animated: false)
            UIView.animate(withDuration: 0.2) {
                self.offset = 0
            }
        }
        
        decelerating = false
    }
}
