//
//  DetailedPresenter.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import Foundation
import UIKit

protocol DetailedViewOutputDelegate: AnyObject {
    func getData()
}

class DetailedPresenter {
    
    var imageLink: String? // ссылка на полное изображение, которую передали из первого модуля
    var username: String? // никнэйм, который передали из первого модуля
    var viewModel: DetailedViewModel? 
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    private var router: DetailedRouterDelegate
    weak private var viewInputDelegate: DetailedViewInputDelegate?
    
    init(router: DetailedRouter, viewInput: DetailedViewInputDelegate?, name: String, link: String) {
        self.router = router
        self.viewInputDelegate = viewInput
        self.imageLink = link
        self.username = name
    }
    
    // Функция, которая загружает полное фото и формирует DetailedViewModel, которую потом передаю в DetailedViewController
    private func configureDetailedViewModel(link: String, completionHandler: (()->())?) {
        guard let url = URL(string: link) else { print("Некорректная ссылка на фото"); return }
        
        var image = UIImage()
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let loadedImage = UIImage(data: data) {
                image = loadedImage
                strongSelf.viewModel = DetailedViewModel(username: strongSelf.username ?? "SoberPear", image: image)
                }
            completionHandler?()
        }.resume()
       
    }
    
}

extension DetailedPresenter: DetailedViewOutputDelegate {
    func getData() {
        configureDetailedViewModel(link: self.imageLink ?? "") { [weak self] in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.viewInputDelegate?.setupData(source: strongSelf.viewModel ?? DetailedViewModel(username: "Cheese", image: UIImage(named: "cheese")!)) // здесь я просто добавил картинку сыра, чтобы было красиво если вдруг модель не соберется 
            }
        }
    }
    
    
}
