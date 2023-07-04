//
//  DeteiledViewController.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import UIKit

protocol DetailedViewInputDelegate: AnyObject {
    func setupData(source: DetailedViewModel)
}

class DetailedViewController: UIViewController {
    
    var viewOutputDelegate: DetailedViewOutputDelegate?
    let imageView = UIImageView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        configureImageView()
        viewOutputDelegate?.getData()
    }
    
    func configureImageView () {
        let safeGuide = self.view.safeAreaLayoutGuide
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.rightAnchor.constraint(equalTo: safeGuide.rightAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: safeGuide.leftAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
        
        imageView.contentMode = .scaleAspectFit
    }
    
}

extension DetailedViewController: DetailedViewInputDelegate {
    func setupData(source: DetailedViewModel) {
        self.title = source.username
        self.imageView.image = source.image
    }
    
    
}
