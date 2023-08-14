//
//  ViewController.swift
//  FrameVsBounds
//
//  Created by Sergei Semko on 8/14/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "image")
        imageView.alpha = 0.4
        return imageView
    }()
    
    private let viewPanel = ViewPanel()
    
    private var flagStop = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
        setupNavigationController()
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
    
    private func setupUI() {
        view.addSubview(containerView)
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        containerView.center = view.center
        
        containerView.addSubview(imageView)
        
        view.addSubview(viewPanel)
        viewPanel.delegate = self
    }
    
    private func setupNavigationController() {
        let rightBarButton = UIBarButtonItem(
            title: "Toggle ClipsToBounds",
            image: nil,
            target: self,
            action: #selector(didBarButtonTapped)
        )
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.prompt = "Clips to bounds:: " + String(containerView.clipsToBounds)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            viewPanel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            viewPanel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            viewPanel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            viewPanel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    private func detailPrint() {
        print("Detail print")
        print("Frame origin x \(containerView.frame.origin.x)")
        print("Frame origin y \(containerView.frame.origin.y)")
        print("Frame size width \(containerView.frame.size.width)")
        print("Frame size height \(containerView.frame.size.height)")
        print("Bounds origin x \(containerView.bounds.origin.x)")
        print("Bounds origin y \(containerView.bounds.origin.y)")
        print("Bounds size width \(containerView.bounds.size.width)")
        print("Bounds size height \(containerView.bounds.size.height)")
        print("Center x: \(containerView.center.x)")
        print("Center y: \(containerView.center.y)")
        print("Rotation \(containerView.transform)")
        print("------------------------------------------------------------------------------")
    }
    
    @objc
    private func didBarButtonTapped() {
        containerView.clipsToBounds.toggle()
        navigationItem.prompt = "Clips to bounds: " + String(containerView.clipsToBounds)
    }
}


extension ViewController: ViewPanelDelegate {
    func getAllDataUpdates() -> UIView {
        return containerView
    }
    
    func didChangeCenterX(value: CGFloat) {
        containerView.center.x = value
        detailPrint()
    }
    
    func didChangeCenterY(value: CGFloat) {
        containerView.center.y = value
        detailPrint()
    }
    
    func didChangeRotation(value: CGFloat) {
        let rotation = CGAffineTransform(rotationAngle: value)
        containerView.transform = rotation
        detailPrint()
    }
    
    func didChangeBoundsX(value: CGFloat) {
        containerView.bounds.origin.x = value
        detailPrint()
    }
    
    func didChangeBoundsY(value: CGFloat) {
        containerView.bounds.origin.y = value
        detailPrint()
    }
    
    func didChangeBoundsWidth(value: CGFloat) {
        containerView.bounds.size.width = value
        detailPrint()
    }
    
    func didChangeBoundsHeight(value: CGFloat) {
        containerView.bounds.size.height = value
        detailPrint()
    }
    
    func didChangeFrameX(value: CGFloat) {
        containerView.frame.origin.x = value
        detailPrint()
    }
    
    func didChangeFrameY(value: CGFloat) {
        containerView.frame.origin.y = value
        detailPrint()
    }
    
    func didChangeFrameWidth(value: CGFloat) {
        containerView.frame.size.width = value
        detailPrint()
    }
    
    func didChangeFrameHeight(value: CGFloat) {
        containerView.frame.size.height = value
        detailPrint()
    }
}


