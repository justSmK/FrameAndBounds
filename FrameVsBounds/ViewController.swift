//
//  ViewController.swift
//  FrameVsBounds
//
//  Created by Sergei Semko on 8/14/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let myView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.alpha = 0.3
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    private let viewPanel = ViewPanel()
    
    private var flagStop = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        myView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.center = view.center
        myView.backgroundColor = .systemRed
        view.addSubview(myView)
        
        view.addSubview(viewPanel)
        viewPanel.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        if flagStop {
            guard let currentScreenData = view.window?.windowScene?.screen.bounds else { return }
            let currentWidth = currentScreenData.width
            let currentHeight = currentScreenData.height
            viewPanel.configurate(currentWidth: currentWidth, currentHeight: currentHeight)
            flagStop = false
        }
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewPanel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            viewPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            viewPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            viewPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    private func detailPrint() {
        print("Detail print")
        print("Frame origin x \(myView.frame.origin.x)")
        print("Frame origin y \(myView.frame.origin.y)")
        print("Frame size width \(myView.frame.size.width)")
        print("Frame size height \(myView.frame.size.height)")
        print("Bounds origin x \(myView.bounds.origin.x)")
        print("Bounds origin y \(myView.bounds.origin.y)")
        print("Bounds size width \(myView.bounds.size.width)")
        print("Bounds size height \(myView.bounds.size.height)")
        print("Center x: \(myView.center.x)")
        print("Center y: \(myView.center.y)")
        print("Rotation \(myView.transform)")
        print("------------------------------------------------------------------------------")
    }
}


extension ViewController: ViewPanelDelegate {
    func getAllDataUpdates() -> UIView {
        return myView
    }
    
    func didChangeCenterX(value: CGFloat) {
        myView.center.x = value
        detailPrint()
    }
    
    func didChangeCenterY(value: CGFloat) {
        myView.center.y = value
        detailPrint()
    }
    
    func didChangeRotation(value: CGFloat) {
        let rotation = CGAffineTransform(rotationAngle: value)
        myView.transform = rotation
        detailPrint()
    }
    
    func didChangeBoundsX(value: CGFloat) {
        myView.bounds.origin.x = value
        detailPrint()
    }
    
    func didChangeBoundsY(value: CGFloat) {
        myView.bounds.origin.y = value
        detailPrint()
    }
    
    func didChangeBoundsWidth(value: CGFloat) {
        myView.bounds.size.width = value
        detailPrint()
    }
    
    func didChangeBoundsHeight(value: CGFloat) {
        myView.bounds.size.height = value
        detailPrint()
    }
    
    func didChangeFrameX(value: CGFloat) {
        myView.frame.origin.x = value
        detailPrint()
    }
    
    func didChangeFrameY(value: CGFloat) {
        myView.frame.origin.y = value
        detailPrint()
    }
    
    func didChangeFrameWidth(value: CGFloat) {
        myView.frame.size.width = value
        detailPrint()
    }
    
    func didChangeFrameHeight(value: CGFloat) {
        myView.frame.size.height = value
        detailPrint()
    }
}


