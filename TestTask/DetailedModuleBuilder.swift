//
//  DetailedModuleBuilder.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import Foundation

class DetailedModuleBuilder {
    static func createSecondModule(name: String, link: String) -> DetailedViewController {
        
        let viewController = DetailedViewController()
        
        let router = DetailedRouter(view: viewController)
        
        let presenter = DetailedPresenter(router: router, viewInput: viewController, name: name, link: link)
        
        viewController.viewOutputDelegate = presenter
        
        return viewController
    }
}
