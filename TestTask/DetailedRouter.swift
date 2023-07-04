//
//  DetailedRouter.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import Foundation
import UIKit

protocol DetailedRouterDelegate: AnyObject {
    
}

final class DetailedRouter {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
}

extension DetailedRouter: DetailedRouterDelegate {
    
}
