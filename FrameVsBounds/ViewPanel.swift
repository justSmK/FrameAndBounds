//
//  ViewPanel.swift
//  TestingApp
//
//  Created by Sergei Semko on 8/14/23.
//

import UIKit

protocol ViewPanelDelegate: AnyObject {
    func didChangeFrameX(value: CGFloat)
    func didChangeFrameY(value: CGFloat)
    func didChangeFrameWidth(value: CGFloat)
    func didChangeFrameHeight(value: CGFloat)
    
    func didChangeBoundsX(value: CGFloat)
    func didChangeBoundsY(value: CGFloat)
    func didChangeBoundsWidth(value: CGFloat)
    func didChangeBoundsHeight(value: CGFloat)
    
    func didChangeCenterX(value: CGFloat)
    func didChangeCenterY(value: CGFloat)
    func didChangeRotation(value: CGFloat)
    
    func getAllDataUpdates() -> UIView
}

class ViewPanel: UIView {
    private let frameXLabel = UILabel()
    private let frameYLabel = UILabel()
    private let frameWidthLabel = UILabel()
    private let frameHeightLabel = UILabel()
    
    private let boundsXLabel = UILabel()
    private let boundsYLabel = UILabel()
    private let boundsWidthLabel = UILabel()
    private let boundsHeightLabel = UILabel()
    
    private let centerXLabel = UILabel()
    private let centerYLabel = UILabel()
    private let rotationLabel = UILabel()
    
    private let frameXSlider = UISlider()
    private let frameYSlider = UISlider()
    private let frameWidthSlider = UISlider()
    private let frameHeightSlider = UISlider()
    
    private let boundsXSlider = UISlider()
    private let boundsYSlider = UISlider()
    private let boundsWidthSlider = UISlider()
    private let boundsHeightSlider = UISlider()
    
    private let centerXSlider = UISlider()
    private let centerYSlider = UISlider()
    private let rotationSlider = UISlider()
    
    
    weak var delegate: ViewPanelDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configurate(currentWidth: CGFloat, currentHeight: CGFloat) {
        frameXSlider.minimumValue = 0
        frameXSlider.maximumValue = Float(currentWidth)
        
        frameYSlider.minimumValue = 0
        frameYSlider.maximumValue = Float(currentHeight)
        
        frameWidthSlider.minimumValue = 10
        frameWidthSlider.maximumValue = Float(currentWidth)
        
        frameHeightSlider.minimumValue = 10
        frameHeightSlider.maximumValue = Float(currentHeight)
        
        boundsXSlider.minimumValue = -Float(currentWidth)
        boundsXSlider.maximumValue = Float(currentWidth)
        
        boundsYSlider.minimumValue = -Float(currentHeight)
        boundsYSlider.maximumValue = Float(currentHeight)
        
        boundsWidthSlider.minimumValue = 30
        boundsWidthSlider.maximumValue = Float(currentWidth)
        
        boundsHeightSlider.minimumValue = 30
        boundsHeightSlider.maximumValue = Float(currentHeight)
        
        centerXSlider.minimumValue = 0
        centerXSlider.maximumValue = Float(currentWidth)
        
        centerYSlider.minimumValue = 0
        centerYSlider.maximumValue = Float(currentHeight)
        
        rotationSlider.minimumValue = 0
        rotationSlider.maximumValue = .pi * 2
        rotationSlider.setValue(.pi, animated: true)
        
        updateLabels()
    }
    
    private func setupUI() {
        
        // MARK: - UILabel
        addSubview(frameXLabel)
        addSubview(frameYLabel)
        addSubview(frameWidthLabel)
        addSubview(frameHeightLabel)
        
        addSubview(boundsXLabel)
        addSubview(boundsYLabel)
        addSubview(boundsWidthLabel)
        addSubview(boundsHeightLabel)
        
        addSubview(centerXLabel)
        addSubview(centerYLabel)
        addSubview(rotationLabel)
        rotationLabel.numberOfLines = 0
        
        frameXLabel.translatesAutoresizingMaskIntoConstraints = false
        frameYLabel.translatesAutoresizingMaskIntoConstraints = false
        frameWidthLabel.translatesAutoresizingMaskIntoConstraints = false
        frameHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        boundsXLabel.translatesAutoresizingMaskIntoConstraints = false
        boundsYLabel.translatesAutoresizingMaskIntoConstraints = false
        boundsWidthLabel.translatesAutoresizingMaskIntoConstraints = false
        boundsHeightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        centerXLabel.translatesAutoresizingMaskIntoConstraints = false
        centerYLabel.translatesAutoresizingMaskIntoConstraints = false
        rotationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        frameXLabel.text = "frame x"
        frameYLabel.text = "frame y"
        frameWidthLabel.text = "frame width"
        frameHeightLabel.text = "frame height"
        
        boundsXLabel.text = "bounds x"
        boundsYLabel.text = "bounds y"
        boundsWidthLabel.text = "bounds width"
        boundsHeightLabel.text = "bounds height"
        
        centerXLabel.text = "center x"
        centerYLabel.text = "center y"
        rotationLabel.text = "rotation "
        
        // MARK: - UISlider
        
        addSubview(frameXSlider)
        addSubview(frameYSlider)
        addSubview(frameWidthSlider)
        addSubview(frameHeightSlider)
        
        addSubview(boundsXSlider)
        addSubview(boundsYSlider)
        addSubview(boundsWidthSlider)
        addSubview(boundsHeightSlider)
        
        addSubview(centerXSlider)
        addSubview(centerYSlider)
        addSubview(rotationSlider)
        
        frameXSlider.translatesAutoresizingMaskIntoConstraints = false
        frameYSlider.translatesAutoresizingMaskIntoConstraints = false
        frameWidthSlider.translatesAutoresizingMaskIntoConstraints = false
        frameHeightSlider.translatesAutoresizingMaskIntoConstraints = false
        
        boundsXSlider.translatesAutoresizingMaskIntoConstraints = false
        boundsYSlider.translatesAutoresizingMaskIntoConstraints = false
        boundsWidthSlider.translatesAutoresizingMaskIntoConstraints = false
        boundsHeightSlider.translatesAutoresizingMaskIntoConstraints = false
        
        centerXSlider.translatesAutoresizingMaskIntoConstraints = false
        centerYSlider.translatesAutoresizingMaskIntoConstraints = false
        rotationSlider.translatesAutoresizingMaskIntoConstraints = false
        
        
        frameXSlider.addTarget(self, action: #selector(frameXSliderChanged), for: .valueChanged)
        frameYSlider.addTarget(self, action: #selector(frameYSliderChanged), for: .valueChanged)
        frameWidthSlider.addTarget(self, action: #selector(frameWidthSliderChanged), for: .valueChanged)
        frameHeightSlider.addTarget(self, action: #selector(frameHeightSliderChanged), for: .valueChanged)
        
        boundsXSlider.addTarget(self, action: #selector(boundsXSliderChanged), for: .valueChanged)
        boundsYSlider.addTarget(self, action: #selector(boundsYSliderChanged), for: .valueChanged)
        boundsWidthSlider.addTarget(self, action: #selector(boundsWidthSliderChanged), for: .valueChanged)
        boundsHeightSlider.addTarget(self, action: #selector(boundsHeightSliderChanged), for: .valueChanged)
        
        centerXSlider.addTarget(self, action: #selector(centerXSliderChanged), for: .valueChanged)
        centerYSlider.addTarget(self, action: #selector(centerYSliderChanged), for: .valueChanged)
        rotationSlider.addTarget(self, action: #selector(rotationSliderChanged), for: .valueChanged)
        
        // MARK: - Constraints
        
        NSLayoutConstraint.activate([
            frameXLabel.topAnchor.constraint(equalTo: topAnchor),
            frameXLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameXLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            frameXSlider.topAnchor.constraint(equalTo: frameXLabel.bottomAnchor),
            frameXSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameXSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            frameYLabel.topAnchor.constraint(equalTo: frameXSlider.bottomAnchor),
            frameYLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameYLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            frameYSlider.topAnchor.constraint(equalTo: frameYLabel.bottomAnchor),
            frameYSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameYSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            frameWidthLabel.topAnchor.constraint(equalTo: frameYSlider.bottomAnchor),
            frameWidthLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameWidthLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            frameWidthSlider.topAnchor.constraint(equalTo: frameWidthLabel.bottomAnchor),
            frameWidthSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameWidthSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            frameHeightLabel.topAnchor.constraint(equalTo: frameWidthSlider.bottomAnchor),
            frameHeightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameHeightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            frameHeightSlider.topAnchor.constraint(equalTo: frameHeightLabel.bottomAnchor),
            frameHeightSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            frameHeightSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // MARK: - Bounds
            
            boundsXLabel.topAnchor.constraint(equalTo: frameHeightSlider.bottomAnchor),
            boundsXLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            boundsXLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            boundsXSlider.topAnchor.constraint(equalTo: boundsXLabel.bottomAnchor),
            boundsXSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            boundsXSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            boundsYLabel.topAnchor.constraint(equalTo: boundsXSlider.bottomAnchor),
            boundsYLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            boundsYLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            boundsYSlider.topAnchor.constraint(equalTo: boundsYLabel.bottomAnchor),
            boundsYSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            boundsYSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            boundsWidthLabel.topAnchor.constraint(equalTo: boundsYSlider.bottomAnchor),
            boundsWidthLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            boundsWidthLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            boundsWidthSlider.topAnchor.constraint(equalTo: boundsWidthLabel.bottomAnchor),
            boundsWidthSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            boundsWidthSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            boundsHeightLabel.topAnchor.constraint(equalTo: boundsWidthSlider.bottomAnchor),
            boundsHeightLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            boundsHeightLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            boundsHeightSlider.topAnchor.constraint(equalTo: boundsHeightLabel.bottomAnchor),
            boundsHeightSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            boundsHeightSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // MARK: - Center, Rotation
            
            centerXLabel.topAnchor.constraint(equalTo: boundsHeightSlider.bottomAnchor),
            centerXLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            centerXLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            centerXSlider.topAnchor.constraint(equalTo: centerXLabel.bottomAnchor),
            centerXSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            centerXSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            centerYLabel.topAnchor.constraint(equalTo: centerXSlider.bottomAnchor),
            centerYLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            centerYLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            centerYSlider.topAnchor.constraint(equalTo: centerYLabel.bottomAnchor),
            centerYSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            centerYSlider.trailingAnchor.constraint(equalTo: trailingAnchor),

            rotationLabel.topAnchor.constraint(equalTo: centerYSlider.bottomAnchor),
            rotationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            rotationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            rotationSlider.topAnchor.constraint(equalTo: rotationLabel.bottomAnchor),
            rotationSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            rotationSlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            rotationSlider.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    private func updateLabels() {
        let sourceData = delegate?.getAllDataUpdates()
        guard let sourceData else { return }
        
        let roundV: Double = 100
        
        frameXLabel.text = "frame x = \(round(sourceData.frame.origin.x * roundV) / roundV)"
        frameYLabel.text = "frame y = \(round(sourceData.frame.origin.y * roundV) / roundV)"
        frameWidthLabel.text = "frame width = \(round(sourceData.frame.size.width * roundV) / roundV)"
        frameHeightLabel.text = "frame height = \(round(sourceData.frame.size.height * roundV) / roundV)"
        boundsXLabel.text = "bounds x = \(round(sourceData.bounds.origin.x * roundV) / roundV)"
        boundsYLabel.text = "bounds y = \(round(sourceData.bounds.origin.y * roundV) / roundV)"
        boundsWidthLabel.text = "bounds width = \(round(sourceData.bounds.size.width * roundV) / roundV)"
        boundsHeightLabel.text = "bounds height = \(round(sourceData.bounds.size.height * roundV) / roundV)"
        centerXLabel.text = "center x = \(round(sourceData.center.x * roundV) / roundV)"
        centerYLabel.text = "center y = \(round(sourceData.center.y * roundV) / roundV)"
        rotationLabel.text = "rotation = \(sourceData.transform)"
        
        let frameOriginX = Float(sourceData.frame.origin.x)
        let frameOriginY = Float(sourceData.frame.origin.y)
        let frameWidth = Float(sourceData.frame.size.width)
        let frameHeight = Float(sourceData.frame.size.height)
        let boundsOriginX = Float(sourceData.bounds.origin.x)
        let boundsOriginY = Float(sourceData.bounds.origin.y)
        let boundsWidth = Float(sourceData.bounds.size.width)
        let boundsHeight = Float(sourceData.bounds.size.height)
        let centerX = Float(sourceData.center.x)
        let centerY = Float(sourceData.center.y)
        
        frameXSlider.setValue(frameOriginX, animated: true)
        frameYSlider.setValue(frameOriginY, animated: true)
        frameWidthSlider.setValue(frameWidth, animated: true)
        frameHeightSlider.setValue(frameHeight, animated: true)
        boundsXSlider.setValue(boundsOriginX, animated: true)
        boundsYSlider.setValue(boundsOriginY, animated: true)
        boundsWidthSlider.setValue(boundsWidth, animated: true)
        boundsHeightSlider.setValue(boundsHeight, animated: true)
        centerXSlider.setValue(centerX, animated: true)
        centerYSlider.setValue(centerY, animated: true)
    }
    
    private func updateSliders() {
        let sourceData = delegate?.getAllDataUpdates()
        guard let sourceData else { return }
        
        let frameOriginX = Float(sourceData.frame.origin.x)
        let frameOriginY = Float(sourceData.frame.origin.y)
        let frameWidth = Float(sourceData.frame.size.width)
        let frameHeight = Float(sourceData.frame.size.height)
        let boundsOriginX = Float(sourceData.bounds.origin.x)
        let boundsOriginY = Float(sourceData.bounds.origin.y)
        let boundsWidth = Float(sourceData.bounds.size.width)
        let boundsHeight = Float(sourceData.bounds.size.height)
        let centerX = Float(sourceData.center.x)
        let centerY = Float(sourceData.center.y)
        
        frameXSlider.setValue(frameOriginX, animated: true)
        frameYSlider.setValue(frameOriginY, animated: true)
        frameWidthSlider.setValue(frameWidth, animated: true)
        frameHeightSlider.setValue(frameHeight, animated: true)
        boundsXSlider.setValue(boundsOriginX, animated: true)
        boundsYSlider.setValue(boundsOriginY, animated: true)
        boundsWidthSlider.setValue(boundsWidth, animated: true)
        boundsHeightSlider.setValue(boundsHeight, animated: true)
        centerXSlider.setValue(centerX, animated: true)
        centerYSlider.setValue(centerY, animated: true)
    }
}

extension ViewPanel {
    @objc private func frameXSliderChanged() {
        delegate?.didChangeFrameX(value: CGFloat(frameXSlider.value))
//        frameXLabel.text = "frame x = \(frameXSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func frameYSliderChanged() {
        delegate?.didChangeFrameY(value: CGFloat(frameYSlider.value))
//        frameYLabel.text = "frame y = \(frameYSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func frameWidthSliderChanged() {
        delegate?.didChangeFrameWidth(value: CGFloat(frameWidthSlider.value))
//        frameWidthLabel.text = "frame width = \(frameWidthSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func frameHeightSliderChanged() {
        delegate?.didChangeFrameHeight(value: CGFloat(frameHeightSlider.value))
//        frameHeightLabel.text = "frame height = \(frameHeightSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func boundsXSliderChanged() {
        delegate?.didChangeBoundsX(value: CGFloat(boundsXSlider.value))
//        boundsXLabel.text = "bounds x = \(boundsXSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func boundsYSliderChanged() {
        delegate?.didChangeBoundsY(value: CGFloat(boundsYSlider.value))
//        boundsYLabel.text = "bounds y = \(boundsYSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func boundsWidthSliderChanged() {
        delegate?.didChangeBoundsWidth(value: CGFloat(boundsWidthSlider.value))
//        boundsWidthLabel.text = "bounds width = \(boundsWidthSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func boundsHeightSliderChanged() {
        delegate?.didChangeBoundsHeight(value: CGFloat(boundsHeightSlider.value))
//        boundsHeightLabel.text = "bounds height = \(boundsHeightSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func centerXSliderChanged() {
        delegate?.didChangeCenterX(value: CGFloat(centerXSlider.value))
//        centerXLabel.text = "center x = \(centerXSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func centerYSliderChanged() {
        delegate?.didChangeCenterY(value: CGFloat(centerYSlider.value))
//        centerYLabel.text = "center y = \(centerYSlider.value)"
        updateLabels()
//        updateSliders()
    }
    
    @objc private func rotationSliderChanged() {
        delegate?.didChangeRotation(value: CGFloat(rotationSlider.value))
//        rotationLabel.text = "rotation = \(rotationSlider.value)"
        updateLabels()
//        updateSliders()
    }
}
