//
//  Model.swift
//  TestTask
//
//  Created by Алексей Волобуев on 03.07.2023.
//

import Foundation
import UIKit

struct Photo: Codable {
    var color: String
    var description: String?
    var altDescription: String?
    var urls: PhotoLink
    var likes: Int
    var user: User

    enum CodingKeys: String, CodingKey {
        case color
        case description
        case altDescription = "alt_description"
        case urls
        case likes
        case user
    }
}

struct PhotoLink: Codable {
    var regular: String
    var thumb: String
}

struct User: Codable {
    var username: String
}

struct MainViewModel {
    var description: String
    var color: UIColor
    var likes: Int
    var image: UIImage
}

struct DetailedViewModel {
    var username: String
    var image: UIImage
}


