//
//  BreedListResponse.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import Foundation

// MARK: - WelcomeElement
struct BreedListResponse: Codable {
    let id: String
    let name: String?
    let image: Image?
}

// MARK: - Image
struct Image: Codable {
    let id: String
    let url: String
}
