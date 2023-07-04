//
//  MainRouter.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import Foundation
import UIKit

protocol MainRouterDelegate {
    func showPhoto(name: String, link: String)
}

final class MainRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
}

extension MainRouter: MainRouterDelegate {
    
    func showPhoto(name: String, link: String) {
        let secondModule = DetailedModuleBuilder.createSecondModule(name: name, link: link) // во второй модуль передается никнейм и ссылка на полное изображение
        view?.navigationController?.pushViewController(secondModule, animated: true)
    }
    
}
