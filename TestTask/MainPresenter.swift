//
//  MainPresenter.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import Foundation
import UIKit

protocol MainViewOutputDelegate: AnyObject {
    func getData()
    func didSelectCell(cellNumber: Int)
}

class MainPresenter {
    
    var modelSource = [MainViewModel]()
    var dataSource = [Photo]()
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    private var router: MainRouterDelegate
    weak private var viewInputDelegate: MainViewInputDelegate?
    
    init(router: MainRouter, viewInput: MainViewInputDelegate?) {
        self.router = router
        self.viewInputDelegate = viewInput
    }
    
    // Функция, которая отправляет запрос на сервер и собирает модели
    private func getEpisodes(link: String, completionHandler: (()->())? ) {
        guard let url = URL(string: link) else { print("Некорректная ссылка"); return }
        
            session.dataTask(with: url) { [weak self] (data, response, error) in
                guard let strongSelf = self else { return }
                
                if let error = error {
                    print("Ошибка при загрузке данных: \(error.localizedDescription)")
                    return
                    }
                    
                guard let data = data else {
                    print("Пустые данные")
                    return
                    }
                
                if error == nil {
                    let response = try? strongSelf.decoder.decode([Photo].self, from: data)
                    strongSelf.dataSource = response ?? []
                } else { print("Ошибка декодирования JSON"); return }
                
                completionHandler?()
            }.resume()
    }
    
    // Функция, которая из первичной моели формирует MainViewModel, которую потом передаю во ViewController
    private func configureMainViewModels(source: [Photo], completionHandler: (()->())?) {
        let dispatchGroup = DispatchGroup()
        
        for photo in source {
            dispatchGroup.enter()
            
            guard let url = URL(string: photo.urls.thumb) else { print("Некорректная ссылка на иконку фото"); return }
            
            var image = UIImage()
            if let data = try? Data(contentsOf: url) {
                image = UIImage(data: data) ?? UIImage()
            }
            
            guard let color = UIColor(hex: photo.color) else { _ = UIColor.black; print("Некорректный формат цвета"); return }
            
            modelSource.append(MainViewModel(description: (photo.description ?? photo.altDescription) ?? "No description", color: color, likes: photo.likes, image: image))
            
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            completionHandler?()
        }
    }
    
    
}

extension MainPresenter: MainViewOutputDelegate {
    func getData() {
        self.getEpisodes(link: "https://api.unsplash.com/photos/?client_id=znAeRuoYk9YGfP9P4l4d7x6apd4oH5AqVXhP-yg6pZw") { [weak self] in
            guard let self = self else { return }
            
            self.configureMainViewModels(source: dataSource) { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.viewInputDelegate?.setupData(source: self.modelSource)
                }
            }
        }
    }
    
    func didSelectCell(cellNumber: Int) {
        router.showPhoto(name: dataSource[cellNumber].user.username, link: dataSource[cellNumber].urls.regular)
    }
    
}
