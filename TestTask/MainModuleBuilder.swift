//
//  MainModuleBuilder.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import Foundation

class MainModuleBuilder {
    static func createFirstModule() -> ViewController {
        
        let viewController = ViewController()
        
        let router = MainRouter(view: viewController)
        
        let presenter = MainPresenter(router: router, viewInput: viewController)
        
        viewController.viewOutputDelegate = presenter
        
        return viewController
    }
}
