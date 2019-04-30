//
//  LoadingOverlayView.swift
//  PingPongRecorder
//
//  Created by Chris Magnuson on 4/29/19.
//  Copyright © 2019 Chris Magnuson. All rights reserved.
//

import UIKit

// Custom loading overlay view
class LoadingOverlayView : UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // Set the color of the loading indicator
    public var color: UIColor? {
        get { return loadingIndicator.color }
        set { loadingIndicator.color = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Setup the loading overlay
    private func setupView() {
        let nib = UINib(nibName: "LoadingOverlayView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        hide()
    }
    
    // Show this view
    public func show() {
        self.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    // Hide this view
    public func hide() {
        self.isHidden = true
        loadingIndicator.stopAnimating()
    }
}
