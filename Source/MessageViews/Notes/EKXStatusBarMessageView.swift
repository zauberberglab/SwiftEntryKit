//
//  EKXStatusBarMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public class EKXStatusBarMessageView: UIView {
    
    // MARK: Props
    private let leadingLabel = UILabel()
    private let trailingLabel = UILabel()

    /// Height of the status bar.
    ///
    /// Fix from QH: `UIApplication.shared.statusBarFrame` is deprecated and does
    /// nothing on iOS 27 — it hands back an infinite rect, and an infinite height
    /// constraint crashes the app with "NSLayoutConstraint constant is not finite".
    /// Ask the window scene instead, which is what AlertService already does.
    private static var statusBarMaxY: CGFloat {
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        let scene = scenes.first { $0.activationState == .foregroundActive } ?? scenes.first
        let maxY = scene?.statusBarManager?.statusBarFrame.maxY ?? 0
        return maxY.isFinite ? maxY : 0
    }

    // MARK: Setup
    public init(leading: EKProperty.LabelContent, trailing: EKProperty.LabelContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(leading: leading, trailing: trailing)
    }
    
    /// New from QH to setup label center of status bar
    public init(center: EKProperty.LabelContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(center: center)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(leading: EKProperty.LabelContent, trailing: EKProperty.LabelContent) {
        clipsToBounds = true
        
        set(.height, of: Self.statusBarMaxY)
        
        addSubview(leadingLabel)
        leadingLabel.content = leading
        
        leadingLabel.layoutToSuperview(axis: .vertically)
        leadingLabel.layoutToSuperview(.leading)
        leadingLabel.layoutToSuperview(.width, ratio: 0.26)
        
        addSubview(trailingLabel)
        trailingLabel.content = trailing
        
        trailingLabel.layoutToSuperview(axis: .vertically)
        trailingLabel.layoutToSuperview(.trailing)
        trailingLabel.layoutToSuperview(.width, ratio: 0.26)
    }
    
    /// New from QH to setup label center of status bar
    private func setup(center: EKProperty.LabelContent) {
        clipsToBounds = true
        
        set(.height, of: Self.statusBarMaxY)
        
        addSubview(leadingLabel)
        leadingLabel.content = center
        
        leadingLabel.layoutToSuperview(axis: .vertically)
        leadingLabel.layoutToSuperview(.centerX)
        leadingLabel.layoutToSuperview(.width, ratio: 0.5)
        
        leadingLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        leadingLabel.layer.shadowOpacity = 0.65
        leadingLabel.layer.shadowRadius = 3
    }
}
