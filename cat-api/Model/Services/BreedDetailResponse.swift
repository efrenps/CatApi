//
//  BreedDetailResponse.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import Foundation

// MARK: - WelcomeElement
struct BreedDetailResponse: Codable {
    let id: String
    let name, description: String?
    let image: Image?
    let intelligence, adaptability, grooming: Int
}
